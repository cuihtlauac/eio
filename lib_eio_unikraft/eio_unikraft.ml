(*
 * Copyright (C) 2023 Thomas Leonard
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

module Low_level = Eio_posix.Low_level

module Stdenv = struct
  open Eio.Std
  open Eio_unix

  type base = <
    stdin  : source_ty r;
    stdout : sink_ty r;
    stderr : sink_ty r;
    (* net : [`Unix | `Generic] Eio.Net.ty r; *)
    (* domain_mgr : Eio.Domain_manager.ty r; *)
    (* process_mgr : Process.mgr_ty r; *)
    clock : float Eio.Time.clock_ty r;
    mono_clock : Eio.Time.Mono.ty r;
    (* fs : Eio.Fs.dir_ty Eio.Path.t; *)
    (* cwd : Eio.Fs.dir_ty Eio.Path.t; *)
    secure_random : Eio.Flow.source_ty r;
    debug : Eio.Debug.t;
    backend_id: string;
  >
end


type stdenv = Stdenv.base

let run main =
  Eio_posix.run @@ fun env ->
  main object (_ : stdenv)
    method stdin = env#stdin
    method stdout = env#stdout
    method stderr = env#stderr
    method debug = env#debug
    method clock = env#clock
    method mono_clock = env#mono_clock
    (* method net = Net.v *)
    (* method process_mgr = Process.mgr *)
    (* method domain_mgr = Domain_mgr.v *)
    (* method cwd = ((Fs.cwd, "") :> Eio.Fs.dir_ty Eio.Path.t) *)
    (* method fs = ((Fs.fs, "") :> Eio.Fs.dir_ty Eio.Path.t) *)
    method secure_random = env#secure_random
    method backend_id = "unikraft"
  end
