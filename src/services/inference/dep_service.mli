(**
 * Copyright (c) 2013-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open Utils_js

val dependent_files:
  reader: Abstract_state_reader.t ->
  MultiWorkerLwt.worker list option -> (* workers *)
  candidates:FilenameSet.t ->
  root_files:FilenameSet.t ->
  root_modules:Modulename.Set.t ->
  (* (transitive_dependents, direct_dependents) of changed_modules *)
  (FilenameSet.t * FilenameSet.t) Lwt.t

type dependency_graph = FilenameSet.t FilenameMap.t

val calc_dependency_info:
  options:Options.t ->
  reader: Mutator_state_reader.t ->
  MultiWorkerLwt.worker list option -> (* workers *)
  parsed:FilenameSet.t ->
  Dependency_info.t Lwt.t

val calc_partial_dependency_info:
  options:Options.t ->
  reader: Mutator_state_reader.t ->
  MultiWorkerLwt.worker list option -> (* workers *)
  FilenameSet.t -> (* files *)
  parsed:FilenameSet.t ->
  Dependency_info.t Lwt.t

val calc_direct_dependencies:
  Dependency_info.t ->
  FilenameSet.t ->
  FilenameSet.t

val calc_all_dependencies:
  Dependency_info.t ->
  FilenameSet.t ->
  FilenameSet.t

val calc_all_reverse_dependencies:
  Dependency_info.t ->
  FilenameSet.t ->
  FilenameSet.t

val filter_dependency_graph:
  dependency_graph ->
  FilenameSet.t -> (* files *)
  dependency_graph
