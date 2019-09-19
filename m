Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC1B85CC
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2019 00:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436509AbfISWYo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Sep 2019 18:24:44 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:48800 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436503AbfISWYn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Sep 2019 18:24:43 -0400
Received: by mail-pg1-f201.google.com with SMTP id w13so3084675pge.15
        for <cgroups@vger.kernel.org>; Thu, 19 Sep 2019 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fKi4ipXKZtUxRnatFigsp7UVvY4teRT8KC5njH9iGG4=;
        b=uO+IehLiqq92DKZn/ip8aTektnIk5JT/JM8x4uHPKbhziQ41OAEFMYMZZTdLEea6wt
         SHAoA56HW+C3PAu2fpljRYz5yjPXSE/cut4hdjITuRuLOHGzsPDm4qDJTO9AIFbbddcR
         Pe1gD2fnSXPW/X8EjxE9ainJbKSUWq2CvErpnuvwRQbpkAJJKU9ghlSy+giM5A48Yy1f
         ckl7omqtLXTuW9mwZHjjLsQ5FIDj+ErisNUJ7xSl8FstpN4wQcs7x0bnIeEgOw/a4q9L
         sTfixRqeslGzhKlb0GmlXV8vN9UIXPOSN8RoXgueFHrtrWkuimqTdogPE9S1yu6BxzWx
         418Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fKi4ipXKZtUxRnatFigsp7UVvY4teRT8KC5njH9iGG4=;
        b=itwXjYiVI36hQtntjpAVVofSI7S3Gvi4Qu5GzqOeZrWN8jsOAywyCf+QxJydG2UrL5
         IboSLUbT9IWGQpeaztMQ1Sgel9W83qTBowhMhWVioH3My13LqTbcHpOEIahOv7/ZQhFB
         36sG97qLQzoUWB6r1FsDhmRYjCLH9v6XBQ+R1noPHpUJSNkwTM6B+oi68ldJzAtgo5uo
         pn5kH0dgCRSJjMJxEpL2JhvWg8mLczfS6Jr4NDEWpqxwpKNMgGJBP+QgcP9Q5MmduNuk
         ViauIa//g/RhK4a/2P11MbXrSmV9jieH4u4ekxyGdXriLWagsSpVtdzrGqJYphgHQsxA
         j3KA==
X-Gm-Message-State: APjAAAUhpIQwLiGvfbJuBBoezRjak1U9rhYirnvUMTSwRDL/VKVX7T6F
        tpVRV8GfHcx67I+WzXxfs4P72Rr8m+qcIGEa1A==
X-Google-Smtp-Source: APXvYqyEGwT8ylc8lQasQCuHKMUF3QpyoJUTFOA6B5U/tyKZRzstnepWxXKgrk5t9yqPzNJjRjJsNOPVvzHEQrBKSw==
X-Received: by 2002:a65:43c6:: with SMTP id n6mr3872952pgp.365.1568931881216;
 Thu, 19 Sep 2019 15:24:41 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:24:20 -0700
In-Reply-To: <20190919222421.27408-1-almasrymina@google.com>
Message-Id: <20190919222421.27408-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v5 6/7] hugetlb_cgroup: Add hugetlb_cgroup reservation tests
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The tests use both shared and private mapped hugetlb memory, and
monitors the hugetlb usage counter as well as the hugetlb reservation
counter. They test different configurations such as hugetlb memory usage
via hugetlbfs, or MAP_HUGETLB, or shmget/shmat, and with and without
MAP_POPULATE.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   1 +
 .../selftests/vm/charge_reserved_hugetlb.sh   | 461 ++++++++++++++++++
 .../selftests/vm/write_hugetlb_memory.sh      |  22 +
 .../testing/selftests/vm/write_to_hugetlbfs.c | 250 ++++++++++
 5 files changed, 735 insertions(+)
 create mode 100755 tools/testing/selftests/vm/charge_reserved_hugetlb.sh
 create mode 100644 tools/testing/selftests/vm/write_hugetlb_memory.sh
 create mode 100644 tools/testing/selftests/vm/write_to_hugetlbfs.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31b3c98b6d34..d3bed9407773 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -14,3 +14,4 @@ virtual_address_range
 gup_benchmark
 va_128TBswitch
 map_fixed_noreplace
+write_to_hugetlbfs
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 9534dc2bc929..31c2cc5cf30b 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
 TEST_GEN_FILES += va_128TBswitch
 TEST_GEN_FILES += virtual_address_range
+TEST_GEN_FILES += write_to_hugetlbfs

 TEST_PROGS := run_vmtests

diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
new file mode 100755
index 000000000000..17315db4111c
--- /dev/null
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -0,0 +1,461 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+if [[ $(id -u) -ne 0 ]]; then
+   echo "This test must be run as root. Skipping..."
+   exit 0
+fi
+
+cgroup_path=/dev/cgroup/memory
+if [[ ! -e $cgroup_path ]]; then
+      mkdir -p $cgroup_path
+      mount -t cgroup -o hugetlb,memory cgroup $cgroup_path
+fi
+
+cleanup () {
+	echo $$ > $cgroup_path/tasks
+
+	if [[ -e /mnt/huge ]]; then
+	      rm -rf /mnt/huge/*
+	      umount /mnt/huge || echo error
+	      rmdir /mnt/huge
+	fi
+	if [[ -e $cgroup_path/hugetlb_cgroup_test ]]; then
+	      rmdir $cgroup_path/hugetlb_cgroup_test
+	fi
+	if [[ -e $cgroup_path/hugetlb_cgroup_test1 ]]; then
+	      rmdir $cgroup_path/hugetlb_cgroup_test1
+	fi
+	if [[ -e $cgroup_path/hugetlb_cgroup_test2 ]]; then
+	      rmdir $cgroup_path/hugetlb_cgroup_test2
+	fi
+	echo 0 > /proc/sys/vm/nr_hugepages
+	echo CLEANUP DONE
+}
+
+function expect_equal() {
+      local expected="$1"
+      local actual="$2"
+      local error="$3"
+
+      if [[ "$expected" != "$actual" ]]; then
+	    echo "expected ($expected) != actual ($actual): $3"
+	    cleanup
+	    exit 1
+      fi
+}
+
+function setup_cgroup() {
+      local name="$1"
+      local cgroup_limit="$2"
+      local reservation_limit="$3"
+
+      mkdir $cgroup_path/$name
+
+      echo writing cgroup limit: "$cgroup_limit"
+      echo "$cgroup_limit" > $cgroup_path/$name/hugetlb.2MB.limit_in_bytes
+
+      echo writing reseravation limit: "$reservation_limit"
+      echo "$reservation_limit" > \
+	    $cgroup_path/$name/hugetlb.2MB.reservation_limit_in_bytes
+      if [ -e "$cgroup_path/$name/cpuset.cpus" ]; then
+	 echo 0 > $cgroup_path/$name/cpuset.cpus
+      fi
+      if [ -e "$cgroup_path/$name/cpuset.mems" ]; then
+	 echo 0 > $cgroup_path/$name/cpuset.mems
+      fi
+}
+
+function wait_for_hugetlb_memory_to_get_depleted {
+   local cgroup="$1"
+   local path="/dev/cgroup/memory/$cgroup/hugetlb.2MB.reservation_usage_in_bytes"
+   # Wait for hugetlbfs memory to get depleted.
+   while [ $(cat $path) != 0 ]; do
+      echo Waiting for hugetlb memory to get depleted.
+      sleep 0.5
+   done
+}
+
+function wait_for_hugetlb_memory_to_get_written {
+   local cgroup="$1"
+   local size="$2"
+
+   local path="/dev/cgroup/memory/$cgroup/hugetlb.2MB.reservation_usage_in_bytes"
+   # Wait for hugetlbfs memory to get written.
+   while [ $(cat $path) != $size ]; do
+      echo Waiting for hugetlb memory to reach size $size.
+      sleep 0.5
+   done
+}
+
+function write_hugetlbfs_and_get_usage() {
+      local cgroup="$1"
+      local size="$2"
+      local populate="$3"
+      local write="$4"
+      local path="$5"
+      local method="$6"
+      local private="$7"
+      local expect_failure="$8"
+
+      # Function return values.
+      reservation_failed=0
+      oom_killed=0
+      hugetlb_difference=0
+      reserved_difference=0
+
+      local hugetlb_usage=$cgroup_path/$cgroup/hugetlb.2MB.usage_in_bytes
+      local reserved_usage=$cgroup_path/$cgroup/hugetlb.2MB.reservation_usage_in_bytes
+
+      local hugetlb_before=$(cat $hugetlb_usage)
+      local reserved_before=$(cat $reserved_usage)
+
+      echo
+      echo Starting:
+      echo hugetlb_usage="$hugetlb_before"
+      echo reserved_usage="$reserved_before"
+      echo expect_failure is "$expect_failure"
+
+      set +e
+      if [[ "$method" == "1" ]] || [[ "$method" == 2 ]] || \
+	    [[ "$private" == "-r" ]] && [[ "$expect_failure" != 1 ]]; then
+	    bash write_hugetlb_memory.sh "$size" "$populate" "$write" \
+		  "$cgroup"  "$path" "$method" "$private" "-l" &
+
+	    local write_result=$?
+	    wait_for_hugetlb_memory_to_get_written "$cgroup" "$size"
+	    echo write_result is $write_result
+      else
+	    bash write_hugetlb_memory.sh "$size" "$populate" "$write" \
+		  "$cgroup"  "$path" "$method" "$private"
+	    local write_result=$?
+      fi
+      set -e
+
+      if [[ "$write_result" == 1 ]]; then
+	    reservation_failed=1
+      fi
+
+      # On linus/master, the above process gets SIGBUS'd on oomkill, with
+      # return code 135. On earlier kernels, it gets actual oomkill, with return
+      # code 137, so just check for both conditions in case we're testing
+      # against an earlier kernel.
+      if [[ "$write_result" == 135 ]] || [[ "$write_result" == 137 ]]; then
+	    oom_killed=1
+      fi
+
+      local hugetlb_after=$(cat $hugetlb_usage)
+      local reserved_after=$(cat $reserved_usage)
+
+      echo After write:
+      echo hugetlb_usage="$hugetlb_after"
+      echo reserved_usage="$reserved_after"
+
+      hugetlb_difference=$(($hugetlb_after - $hugetlb_before))
+      reserved_difference=$(($reserved_after - $reserved_before))
+}
+
+function cleanup_hugetlb_memory() {
+      set +e
+      local cgroup="$1"
+      if [[ "$(pgrep write_to_hugetlbfs)" != "" ]]; then
+	    echo kiling write_to_hugetlbfs
+	    killall -2 write_to_hugetlbfs
+	    wait_for_hugetlb_memory_to_get_depleted $cgroup
+      fi
+      set -e
+
+      if [[ -e /mnt/huge ]]; then
+	    rm -rf /mnt/huge/*
+	      umount /mnt/huge
+	      rmdir /mnt/huge
+      fi
+}
+
+function run_test() {
+      local size="$1"
+      local populate="$2"
+      local write="$3"
+      local cgroup_limit="$4"
+      local reservation_limit="$5"
+      local nr_hugepages="$6"
+      local method="$7"
+      local private="$8"
+      local expect_failure="$9"
+
+      # Function return values.
+      hugetlb_difference=0
+      reserved_difference=0
+      reservation_failed=0
+      oom_killed=0
+
+      echo nr hugepages = "$nr_hugepages"
+      echo "$nr_hugepages" > /proc/sys/vm/nr_hugepages
+
+      setup_cgroup "hugetlb_cgroup_test" "$cgroup_limit" "$reservation_limit"
+
+      mkdir -p /mnt/huge
+      mount -t hugetlbfs \
+	    -o pagesize=2M,size=256M none /mnt/huge
+
+      write_hugetlbfs_and_get_usage "hugetlb_cgroup_test" "$size" "$populate" \
+	    "$write" "/mnt/huge/test" "$method" "$private" "$expect_failure"
+
+      cleanup_hugetlb_memory "hugetlb_cgroup_test"
+
+      local final_hugetlb=$(cat $cgroup_path/hugetlb_cgroup_test/hugetlb.2MB.usage_in_bytes)
+      local final_reservation=$(cat $cgroup_path/hugetlb_cgroup_test/hugetlb.2MB.reservation_usage_in_bytes)
+
+      expect_equal "0" "$final_hugetlb" "final hugetlb is not zero"
+      expect_equal "0" "$final_reservation" "final reservation is not zero"
+}
+
+function run_multiple_cgroup_test() {
+      local size1="$1"
+      local populate1="$2"
+      local write1="$3"
+      local cgroup_limit1="$4"
+      local reservation_limit1="$5"
+
+      local size2="$6"
+      local populate2="$7"
+      local write2="$8"
+      local cgroup_limit2="$9"
+      local reservation_limit2="${10}"
+
+      local nr_hugepages="${11}"
+      local method="${12}"
+      local private="${13}"
+      local expect_failure="${14}"
+
+      # Function return values.
+      hugetlb_difference1=0
+      reserved_difference1=0
+      reservation_failed1=0
+      oom_killed1=0
+
+      hugetlb_difference2=0
+      reserved_difference2=0
+      reservation_failed2=0
+      oom_killed2=0
+
+
+      echo nr hugepages = "$nr_hugepages"
+      echo "$nr_hugepages" > /proc/sys/vm/nr_hugepages
+
+      setup_cgroup "hugetlb_cgroup_test1" "$cgroup_limit1" "$reservation_limit1"
+      setup_cgroup "hugetlb_cgroup_test2" "$cgroup_limit2" "$reservation_limit2"
+
+      mkdir -p /mnt/huge
+      mount -t hugetlbfs \
+	    -o pagesize=2M,size=256M none /mnt/huge
+
+      write_hugetlbfs_and_get_usage "hugetlb_cgroup_test1" "$size1" \
+	    "$populate1" "$write1" "/mnt/huge/test1" "$method" "$private" \
+	    "$expect_failure"
+
+      hugetlb_difference1=$hugetlb_difference
+      reserved_difference1=$reserved_difference
+      reservation_failed1=$reservation_failed
+      oom_killed1=$oom_killed
+
+      local cgroup1_hugetlb_usage=$cgroup_path/hugetlb_cgroup_test1/hugetlb.2MB.usage_in_bytes
+      local cgroup1_reservation_usage=$cgroup_path/hugetlb_cgroup_test1/hugetlb.2MB.reservation_usage_in_bytes
+      local cgroup2_hugetlb_usage=$cgroup_path/hugetlb_cgroup_test2/hugetlb.2MB.usage_in_bytes
+      local cgroup2_reservation_usage=$cgroup_path/hugetlb_cgroup_test2/hugetlb.2MB.reservation_usage_in_bytes
+
+      local usage_before_second_write=$(cat $cgroup1_hugetlb_usage)
+      local reservation_usage_before_second_write=$(cat \
+	    $cgroup1_reservation_usage)
+
+      write_hugetlbfs_and_get_usage "hugetlb_cgroup_test2" "$size2" \
+	    "$populate2" "$write2" "/mnt/huge/test2" "$method" "$private" \
+	    "$expect_failure"
+
+      hugetlb_difference2=$hugetlb_difference
+      reserved_difference2=$reserved_difference
+      reservation_failed2=$reservation_failed
+      oom_killed2=$oom_killed
+
+      expect_equal "$usage_before_second_write" \
+	    "$(cat $cgroup1_hugetlb_usage)" "Usage changed."
+      expect_equal "$reservation_usage_before_second_write" \
+	    "$(cat $cgroup1_reservation_usage)" "Reservation usage changed."
+
+      cleanup_hugetlb_memory
+
+      local final_hugetlb=$(cat $cgroup1_hugetlb_usage)
+      local final_reservation=$(cat $cgroup1_reservation_usage)
+
+      expect_equal "0" "$final_hugetlb" \
+	    "hugetlbt_cgroup_test1 final hugetlb is not zero"
+      expect_equal "0" "$final_reservation" \
+	    "hugetlbt_cgroup_test1 final reservation is not zero"
+
+      local final_hugetlb=$(cat $cgroup2_hugetlb_usage)
+      local final_reservation=$(cat $cgroup2_reservation_usage)
+
+      expect_equal "0" "$final_hugetlb" \
+	    "hugetlb_cgroup_test2 final hugetlb is not zero"
+      expect_equal "0" "$final_reservation" \
+	    "hugetlb_cgroup_test2 final reservation is not zero"
+}
+
+cleanup
+
+for private in "" "-r" ; do
+for populate in  "" "-o"; do
+for method in 0 1 2; do
+
+# Skip mmap(MAP_HUGETLB | MAP_SHARED). Doesn't seem to be supported.
+if [[ "$method" == 1 ]] && [[ "$private" == "" ]]; then
+      continue
+fi
+
+# Skip populated shmem tests. Doesn't seem to be supported.
+if [[ "$method" == 2"" ]] && [[ "$populate" == "-o" ]]; then
+      continue
+fi
+
+cleanup
+echo
+echo
+echo
+echo Test normal case.
+echo private=$private, populate=$populate, method=$method
+run_test $((10 * 1024 * 1024)) "$populate" "" $((20 * 1024 * 1024)) \
+      $((20 * 1024 * 1024)) 10 "$method" "$private" "0"
+
+echo Memory charged to hugtlb=$hugetlb_difference
+echo Memory charged to reservation=$reserved_difference
+
+if [[ "$populate" == "-o" ]]; then
+      expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference" \
+	    "Reserved memory charged to hugetlb cgroup."
+else
+      expect_equal "0" "$hugetlb_difference" \
+	    "Reserved memory charged to hugetlb cgroup."
+fi
+
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference" \
+      "Reserved memory not charged to reservation usage."
+echo 'PASS'
+
+cleanup
+echo
+echo
+echo
+echo Test normal case with write.
+echo private=$private, populate=$populate, method=$method
+run_test $((10 * 1024 * 1024)) "$populate" '-w' $((20 * 1024 * 1024)) \
+      $((20 * 1024 * 1024)) 10 "$method" "$private" "0"
+
+echo Memory charged to hugtlb=$hugetlb_difference
+echo Memory charged to reservation=$reserved_difference
+
+expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference" \
+      "Reserved memory charged to hugetlb cgroup."
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference" \
+      "Reserved memory not charged to reservation usage."
+echo 'PASS'
+
+
+cleanup
+echo
+echo
+echo
+echo Test more than reservation case.
+echo private=$private, populate=$populate, method=$method
+run_test "$((10 * 1024 * 1024))" "$populate" '' "$((20 * 1024 * 1024))" \
+      "$((5 * 1024 * 1024))" "10" "$method" "$private" "1"
+
+expect_equal "1" "$reservation_failed" "Reservation succeeded."
+echo 'PASS'
+
+cleanup
+
+echo
+echo
+echo
+echo Test more than cgroup limit case.
+echo private=$private, populate=$populate, method=$method
+
+# Not sure if shm memory can be cleaned up when the process gets sigbus'd.
+if [[ "$method" != 2 ]]; then
+      run_test $((10 * 1024 * 1024)) "$populate" "-w" $((5 * 1024 * 1024)) \
+	    $((20 * 1024 * 1024)) 10 "$method" "$private" "1"
+
+      expect_equal "1" "$oom_killed" "Not oom killed."
+fi
+echo 'PASS'
+
+cleanup
+
+echo
+echo
+echo
+echo Test normal case, multiple cgroups.
+echo private=$private, populate=$populate, method=$method
+run_multiple_cgroup_test "$((6 * 1024 * 1024))" "$populate" "" \
+      "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "$((10 * 1024 * 1024))" \
+      "$populate" "" "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "10" \
+      "$method" "$private" "0"
+
+echo Memory charged to hugtlb1=$hugetlb_difference1
+echo Memory charged to reservation1=$reserved_difference1
+echo Memory charged to hugtlb2=$hugetlb_difference2
+echo Memory charged to reservation2=$reserved_difference2
+
+expect_equal "$((6 * 1024 * 1024))" "$reserved_difference1" \
+      "Incorrect reservations charged to cgroup 1."
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference2" \
+      "Incorrect reservation charged to cgroup 2."
+if [[ "$populate" == "-o" ]]; then
+      expect_equal "$((6 * 1024 * 1024))" "$hugetlb_difference1" \
+	    "Incorrect hugetlb charged to cgroup 1."
+      expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference2" \
+	    "Incorrect hugetlb charged to cgroup 2."
+else
+      expect_equal "0" "$hugetlb_difference1" \
+	    "Incorrect hugetlb charged to cgroup 1."
+      expect_equal "0" "$hugetlb_difference2" \
+	    "Incorrect hugetlb charged to cgroup 2."
+fi
+echo 'PASS'
+
+cleanup
+echo
+echo
+echo
+echo Test normal case with write, multiple cgroups.
+echo private=$private, populate=$populate, method=$method
+run_multiple_cgroup_test "$((6 * 1024 * 1024))" "$populate" "-w" \
+      "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "$((10 * 1024 * 1024))" \
+      "$populate" "-w" "$((20 * 1024 * 1024))" "$((20 * 1024 * 1024))" "10" \
+      "$method" "$private" "0"
+
+echo Memory charged to hugtlb1=$hugetlb_difference1
+echo Memory charged to reservation1=$reserved_difference1
+echo Memory charged to hugtlb2=$hugetlb_difference2
+echo Memory charged to reservation2=$reserved_difference2
+
+expect_equal "$((6 * 1024 * 1024))" "$hugetlb_difference1" \
+      "Incorrect hugetlb charged to cgroup 1."
+expect_equal "$((6 * 1024 * 1024))" "$reserved_difference1" \
+      "Incorrect reservation charged to cgroup 1."
+expect_equal "$((10 * 1024 * 1024))" "$hugetlb_difference2" \
+      "Incorrect hugetlb charged to cgroup 2."
+expect_equal "$((10 * 1024 * 1024))" "$reserved_difference2" \
+      "Incorrected reservation charged to cgroup 2."
+echo 'PASS'
+
+cleanup
+
+done # private
+done # populate
+done # method
+
+umount $cgroup_path
+rmdir $cgroup_path
diff --git a/tools/testing/selftests/vm/write_hugetlb_memory.sh b/tools/testing/selftests/vm/write_hugetlb_memory.sh
new file mode 100644
index 000000000000..08f5fa5527cf
--- /dev/null
+++ b/tools/testing/selftests/vm/write_hugetlb_memory.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+size=$1
+populate=$2
+write=$3
+cgroup=$4
+path=$5
+method=$6
+private=$7
+want_sleep=$8
+
+echo "Putting task in cgroup '$cgroup'"
+echo $$ > /dev/cgroup/memory/"$cgroup"/tasks
+
+echo "Method is $method"
+
+set +e
+./write_to_hugetlbfs -p "$path" -s "$size" "$write" "$populate" -m "$method" \
+      "$private" "$want_sleep"
diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testing/selftests/vm/write_to_hugetlbfs.c
new file mode 100644
index 000000000000..03e71c5911be
--- /dev/null
+++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program reserves and uses hugetlb memory, supporting a bunch of
+ * scenarios needed by the charged_reserved_hugetlb.sh test.
+ */
+
+#include <err.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+/* Global definitions. */
+enum method {
+	HUGETLBFS,
+	MMAP_MAP_HUGETLB,
+	SHM,
+	MAX_METHOD
+};
+
+
+/* Global variables. */
+static const char *self;
+static char *shmaddr;
+static int shmid;
+
+/*
+ * Show usage and exit.
+ */
+static void exit_usage(void)
+{
+	printf("Usage: %s -p <path to hugetlbfs file> -s <size to map> "
+	       "[-m <0=hugetlbfs | 1=mmap(MAP_HUGETLB)>] [-l] [-r] "
+	       "[-o] [-w]\n",
+	       self);
+	exit(EXIT_FAILURE);
+}
+
+void sig_handler(int signo)
+{
+	printf("Received %d.\n", signo);
+	if (signo == SIGINT) {
+		printf("Deleting the memory\n");
+		if (shmdt((const void *)shmaddr) != 0) {
+			perror("Detach failure");
+			shmctl(shmid, IPC_RMID, NULL);
+			exit(4);
+		}
+
+		shmctl(shmid, IPC_RMID, NULL);
+		printf("Done deleting the memory\n");
+	}
+	exit(2);
+}
+
+int main(int argc, char **argv)
+{
+	int fd = 0;
+	int key = 0;
+	int *ptr = NULL;
+	int c = 0;
+	int size = 0;
+	char path[256] = "";
+	enum method method = MAX_METHOD;
+	int want_sleep = 0, private = 0;
+	int populate = 0;
+	int write = 0;
+
+	unsigned long i;
+
+	if (signal(SIGINT, sig_handler) == SIG_ERR)
+		err(1, "\ncan't catch SIGINT\n");
+
+	/* Parse command-line arguments. */
+	setvbuf(stdout, NULL, _IONBF, 0);
+	self = argv[0];
+
+	while ((c = getopt(argc, argv, "s:p:m:owlr")) != -1) {
+		switch (c) {
+		case 's':
+			size = atoi(optarg);
+			break;
+		case 'p':
+			strncpy(path, optarg, sizeof(path));
+			break;
+		case 'm':
+			if (atoi(optarg) >= MAX_METHOD) {
+				errno = EINVAL;
+				perror("Invalid -m.");
+				exit_usage();
+			}
+			method = atoi(optarg);
+			break;
+		case 'o':
+			populate = 1;
+			break;
+		case 'w':
+			write = 1;
+			break;
+		case 'l':
+			want_sleep = 1;
+			break;
+		case 'r':
+		    private
+			= 1;
+			break;
+		default:
+			errno = EINVAL;
+			perror("Invalid arg");
+			exit_usage();
+		}
+	}
+
+	if (strncmp(path, "", sizeof(path)) != 0) {
+		printf("Writing to this path: %s\n", path);
+	} else {
+		errno = EINVAL;
+		perror("path not found");
+		exit_usage();
+	}
+
+	if (size != 0) {
+		printf("Writing this size: %d\n", size);
+	} else {
+		errno = EINVAL;
+		perror("size not found");
+		exit_usage();
+	}
+
+	if (!populate)
+		printf("Not populating.\n");
+	else
+		printf("Populating.\n");
+
+	if (!write)
+		printf("Not writing to memory.\n");
+
+	if (method == MAX_METHOD) {
+		errno = EINVAL;
+		perror("-m Invalid");
+		exit_usage();
+	} else
+		printf("Using method=%d\n", method);
+
+	if (!private)
+		printf("Shared mapping.\n");
+	else
+		printf("Private mapping.\n");
+
+	switch (method) {
+	case HUGETLBFS:
+		printf("Allocating using HUGETLBFS.\n");
+		fd = open(path, O_CREAT | O_RDWR, 0777);
+		if (fd == -1)
+			err(1, "Failed to open file.");
+
+		ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			   (private ? MAP_PRIVATE : MAP_SHARED) |
+				   (populate ? MAP_POPULATE : 0),
+			   fd, 0);
+
+		if (ptr == MAP_FAILED) {
+			close(fd);
+			err(1, "Error mapping the file");
+		}
+		break;
+	case MMAP_MAP_HUGETLB:
+		printf("Allocating using MAP_HUGETLB.\n");
+		ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			   (private ? (MAP_PRIVATE | MAP_ANONYMOUS) :
+				      MAP_SHARED) |
+				   MAP_HUGETLB | (populate ? MAP_POPULATE : 0),
+			   -1, 0);
+
+		if (ptr == MAP_FAILED)
+			err(1, "mmap");
+
+		printf("Returned address is %p\n", ptr);
+		break;
+	case SHM:
+		printf("Allocating using SHM.\n");
+		shmid = shmget(key, size,
+			       SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
+		if (shmid < 0) {
+			shmid = shmget(++key, size,
+				       SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
+			if (shmid < 0)
+				err(1, "shmget");
+		}
+		printf("shmid: 0x%x, shmget key:%d\n", shmid, key);
+
+		shmaddr = shmat(shmid, NULL, 0);
+		if (shmaddr == (char *)-1) {
+			perror("Shared memory attach failure");
+			shmctl(shmid, IPC_RMID, NULL);
+			exit(2);
+		}
+		printf("shmaddr: %p\n", shmaddr);
+
+		break;
+	default:
+		errno = EINVAL;
+		err(1, "Invalid method.");
+	}
+
+	if (write) {
+		printf("Writing to memory.\n");
+		if (method != SHM) {
+			memset(ptr, 1, size);
+		} else {
+			printf("Starting the writes:\n");
+			for (i = 0; i < size; i++) {
+				shmaddr[i] = (char)(i);
+				if (!(i % (1024 * 1024)))
+					printf(".");
+			}
+			printf("\n");
+
+			printf("Starting the Check...");
+			for (i = 0; i < size; i++)
+				if (shmaddr[i] != (char)i) {
+					printf("\nIndex %lu mismatched\n", i);
+					exit(3);
+				}
+			printf("Done.\n");
+		}
+	}
+
+	if (want_sleep) {
+		/* Signal to caller that we're done. */
+		printf("DONE\n");
+
+		/* Hold memory until external kill signal is delivered. */
+		while (1)
+			sleep(100);
+	}
+
+	switch (method == HUGETLBFS) {
+		close(fd);
+	}
+
+	return 0;
+}
--
2.23.0.351.gc4317032e6-goog
