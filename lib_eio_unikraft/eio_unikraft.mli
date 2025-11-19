(** Eio backend for Unikraft systems. *)


module Low_level = Eio_posix.Low_level
(** Low-level API for making POSIX calls directly. *)

module Stdenv: sig
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


val run : (stdenv -> 'a) -> 'a
(** [run main] runs an event loop and calls [main stdenv] inside it. *)

