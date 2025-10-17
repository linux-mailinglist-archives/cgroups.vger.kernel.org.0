Return-Path: <cgroups+bounces-10877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BBBEB9B3
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 22:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 911734F5C15
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379943491C9;
	Fri, 17 Oct 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3P9F6j+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24C336EF6
	for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732019; cv=none; b=GdyEK2pFCCywXd3DeqlzGrJ7/cZVXNd/TNPd759py7t2X41UmwgO9XAM1W/G41Hk5ZwmgURCoh+VHrcHsWBDI+jrElwL9jWbo7samnic+UXvqumRCSbFmBLtHp3T/cQCTl+rZPy434oLOqNDaRYYDjqndchj8My7X6dLXHxQYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732019; c=relaxed/simple;
	bh=0iOSFx0ynK1roVDIm+WpuX2yPOT/D5n3AIvP6cQdk3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PZHj0BMNgqXe0a61jcciPQhMFT0kVkQKj4HIA9GTymiVqByILbpgjRwsW2z+Tg0Ryp2c7X1WD9dFIzuGJCQ0yryMjwILQbUiUg89qA8tKe1onCPriRf8/g+6dy+BXWX/D3LvThLxB8BLviMbJ7etjAW9u9ZtPhRQCCHMbIs+81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3P9F6j+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so3600593a12.1
        for <cgroups@vger.kernel.org>; Fri, 17 Oct 2025 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732008; x=1761336808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzgK6COwXxwuR6mHkO/eruasOK9Vha2WZDtBxyLasHc=;
        b=G3P9F6j+k9JJrVqAHHAKC2SBtFcG+vijXy/7/QcvxJa1QwMt8hPjlIY/HTGXrALji6
         TUuvi9dNGJDlS9rYkDo1QWhTrfGLXWrVqNDTwvn4S8r+Lk1WNc3dVp0OM7QisHvXNqsp
         bezjMkOdECuIOol2hFZDyoV8SdTRe0xiIolKCBHG8tKRqm39lwUnUTK1jBYM0MCfhsvv
         2yLYzV+vG4cRROriClumvUylDm+2edyS2B8jAz56X6pYQGHc8navxpg221NZUYGrD6rz
         TIGsZNtToFezT/kqPwqwxUcz8439107YqaFTeQLqlM9d8Al+hqH/Rd5khqzzjlvj9q+L
         4HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732008; x=1761336808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzgK6COwXxwuR6mHkO/eruasOK9Vha2WZDtBxyLasHc=;
        b=OOyxVg0QeY1RaqUbCaZzrmpd0OIJ32H5JpP/xXAWitioy2c9fh7MDNVN8QJBz0s366
         mVX02l4hpt7f2Q8OiiAEt3A3HeHD4HZi9UeL6v+8c92VM/44Y1n7zkI7ieA0ReJhxkl4
         uPRyJCLkHHBpbiTJfQhPA5HxiQNxCXC4J1nqVdk20nn1iUCQcUKSa0k+fZH9z017n2xk
         Y76fyFXQ90L1fUOZCYiOFqKnoK1Kz4GYPSJCpENHx+vyxw5EAcp0oGJeUwpc2i5PPKVZ
         pvHVOTpi/z8kSG6XNINUj4hRW+2zTCethu5e5NCdDbACTDWTi6+1ZdNLRnGCOWULmi0Z
         x3XA==
X-Gm-Message-State: AOJu0YyTK9U2eAWxJlL7rfSnMnbWwC0YeQfC56RVQbYFB8SA9l3+AaMl
	ktjw6Fuoq4DQ7ao1rkvq0uAYMJXYSZgOP+OgcbV2n3hmmluXFFSgaLRj2mLtOlVCBAb3Q0pYH0Q
	rDng74c9FzFeLhfhpjNg+sPMTgTIYOVzxUXTO6cn/O4+8Nd0R052xABadh4AoSfebUqBiSkVj4U
	1QXC7jap93K+Kr5P7kVvrW6d301yeI+2H+DuwLDhpwa3/v0pb7jeo2XjrEzfZztmYc
X-Google-Smtp-Source: AGHT+IFNzBy4Dam1f3BpOkFlbzCEecrwBUddmzLCsmOoaaTEsa8+5gND5yEQLFxm84fuelz2mmjzrymU0o0/N3s+mA==
X-Received: from pjbsv12.prod.google.com ([2002:a17:90b:538c:b0:33b:9921:8e9a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:e291:b0:307:a015:37ef with SMTP id adf61e73a8af0-334a84da469mr6804101637.20.1760732007289;
 Fri, 17 Oct 2025 13:13:27 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:16 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <e51298f79233cc44a14ff2d3659b20cc3767e6bb.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 35/37] KVM: selftests: Add script to exercise private_mem_conversions_test
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Add a wrapper script to simplify running the private_mem_conversions_test
with a variety of configurations. Manually invoking the test for all
supported memory backing source types is tedious.

The script automatically detects the availability of 2MB and 1GB hugepages
and builds a list of source types to test. It then iterates through the
list, running the test for each type with both a single memslot and
multiple memslots.

This makes it easier to get comprehensive test coverage across different
memory configurations.

Use python to be able to issue an ioctl to /dev/kvm.

Update .gitignore to allowlist python scripts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 .../kvm/x86/private_mem_conversions_test.py   | 159 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100755 tools/testing/selftests/kvm/x86/private_mem_conversions_test.py

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 1d41a046a7bfd..d7e9c1d97e376 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -4,6 +4,7 @@
 !*.c
 !*.h
 !*.S
+!*.py
 !*.sh
 !.gitignore
 !config
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.py b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.py
new file mode 100755
index 0000000000000..32421ae824d64
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.py
@@ -0,0 +1,159 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Wrapper script which runs different test setups of
+# private_mem_conversions_test.
+#
+# Copyright (C) 2025, Google LLC.
+
+import os
+import fcntl
+import sys
+import subprocess
+
+
+NUM_VCPUS_TO_TEST = 4
+NUM_MEMSLOTS_TO_TEST = NUM_VCPUS_TO_TEST
+
+# Required pages are based on the test setup in the C code.
+# These static requirements are set to the maximum required for
+# NUM_VCPUS_TO_TEST, over all the hugetlb-related tests
+REQUIRED_NUM_2M_HUGEPAGES = 1024 * NUM_VCPUS_TO_TEST
+REQUIRED_NUM_1G_HUGEPAGES = 2 * NUM_VCPUS_TO_TEST
+
+
+def get_hugepage_count(page_size_kb: int) -> int:
+    """Reads the current number of hugepages available for a given size."""
+    try:
+        path = f"/sys/kernel/mm/hugepages/hugepages-{page_size_kb}kB/nr_hugepages"
+        with open(path, 'r') as f:
+            return int(f.read().strip())
+    except (FileNotFoundError, ValueError):
+        return 0
+
+
+def get_default_hugepage_size_in_kb():
+    """Reads the default hugepage size from /proc/meminfo."""
+    try:
+        with open("/proc/meminfo", 'r') as f:
+            for line in f:
+                if line.startswith("Hugepagesize:"):
+                    parts = line.split()
+                    if len(parts) >= 2 and parts[1].isdigit():
+                        return int(parts[1])
+    except FileNotFoundError:
+        return None
+
+
+def run_tests(executable_path: str, src_type: str, num_memslots: int, num_vcpus: int) -> None:
+    """Runs the test executable with different arguments."""
+    print(f"Running tests for backing source type: {src_type}")
+
+    command1 = [executable_path, "-s", src_type, "-m", str(num_memslots)]
+    print(" ".join(command1))
+    _ = subprocess.run(command1, check=True)
+
+    command2 = [executable_path, "-s", src_type, "-m", str(num_memslots), "-n", str(num_vcpus)]
+    print(" ".join(command2))
+    _ = subprocess.run(command2, check=True)
+
+
+def kvm_check_cap(capability: int) -> int:
+    KVM_CHECK_EXTENSION = 0xAE03
+    KVM_DEVICE = '/dev/kvm'
+
+    if not os.path.exists(KVM_DEVICE):
+        print(f"Error: KVM device not found at {KVM_DEVICE}. Is the 'kvm' module loaded?")
+        return -1
+
+    try:
+        fd = os.open(KVM_DEVICE, os.O_RDWR)
+
+        # Issue the ioctl: fcntl.ioctl(fd, request, arg)
+        # request is KVM_CHECK_EXTENSION (0xAE03)
+        # arg is the capability constant (e.g., KVM_CAP_COALESCED_MMIO)
+        result = fcntl.ioctl(fd, KVM_CHECK_EXTENSION, capability)
+
+        os.close(fd)
+        return result
+    except OSError as e:
+        print(f"Error issuing KVM ioctl on {KVM_DEVICE}: {e}", file=sys.stderr)
+        if fd > 0:
+            os.close(fd)
+        return -1
+
+
+def kvm_has_gmem_attributes() -> bool:
+    KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES = 245
+
+    return kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0
+
+
+def get_backing_source_types() -> list[str]:
+    hugepage_2mb_count = get_hugepage_count(2048)
+    hugepage_2mb_enabled = hugepage_2mb_count >= REQUIRED_NUM_2M_HUGEPAGES
+    hugepage_1gb_count = get_hugepage_count(1048576)
+    hugepage_1gb_enabled = hugepage_1gb_count >= REQUIRED_NUM_1G_HUGEPAGES
+
+    default_hugepage_size_kb = get_default_hugepage_size_in_kb()
+    hugepage_default_enabled = False
+    if default_hugepage_size_kb == 2048:
+        hugepage_default_enabled = hugepage_2mb_enabled
+    elif default_hugepage_size_kb == 1048576:
+        hugepage_default_enabled = hugepage_1gb_enabled
+
+    backing_src_types: list[str] = ["anonymous", "anonymous_thp"]
+
+    if hugepage_default_enabled:
+        backing_src_types.append("anonymous_hugetlb")
+    else:
+        print("skipping anonymous_hugetlb backing source type")
+
+    if hugepage_2mb_enabled:
+        backing_src_types.append("anonymous_hugetlb_2mb")
+    else:
+        print("skipping anonymous_hugetlb_2mb backing source type")
+
+    if hugepage_1gb_enabled:
+        backing_src_types.append("anonymous_hugetlb_1gb")
+    else:
+        print("skipping anonymous_hugetlb_1gb backing source type")
+
+    backing_src_types.append("shmem")
+
+    if hugepage_default_enabled:
+        backing_src_types.append("shared_hugetlb")
+    else:
+        print("skipping shared_hugetlb backing source type")
+
+    return backing_src_types
+
+
+def main():
+    script_dir = os.path.dirname(os.path.abspath(__file__))
+    test_executable = os.path.join(script_dir, "private_mem_conversions_test")
+
+    if not os.path.exists(test_executable):
+        print(f"Error: Test executable not found at '{test_executable}'", file=sys.stderr)
+        sys.exit(1)
+
+    return_code = 0
+
+    backing_src_types = ["shmem"] if kvm_has_gmem_attributes() else get_backing_source_types()
+    try:
+        for i, src_type in enumerate(backing_src_types):
+            if i > 0:
+                print()
+            run_tests(test_executable, src_type, NUM_MEMSLOTS_TO_TEST, NUM_VCPUS_TO_TEST)
+    except subprocess.CalledProcessError as e:
+        print(f"Test failed for source type '{src_type}'. Command: {' '.join(e.cmd)}", file=sys.stderr)
+        return_code = e.returncode
+    except Exception as e:
+        print(f"An unexpected error occurred: {e}", file=sys.stderr)
+        return_code = 1
+
+    sys.exit(return_code)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.51.0.858.gf9c4a03a3a-goog


