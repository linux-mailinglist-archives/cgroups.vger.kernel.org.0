Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C707A0D38
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfH1WG3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40231 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfH1WG3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id g4so1381644qtq.7;
        Wed, 28 Aug 2019 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6kVIFEhxFXj2VwKuP8wNFEI6LlDjARsvOHaqSOLV2+M=;
        b=VBmUEzWmOjIiq6Fy+mPjDu6xFByq2AEJi/Mek/smOE6AgZA8Cav9ZMfa3PXNxZe+P9
         og4HGaLKIcpIJ6rXYXjd/5u+DiyTTNzWSve3YjXGv9pVi6vEIIiThEsa/AkoTb/q+qMv
         G77M7InKfNzylFDnomt+lFaPO0wgoCfKIMw2gi+LEmflI5fjG+sCBleA0NbUWun6+3hQ
         t4HcKj94n8Zkqy3kjOMLjEM+v/e/cgawWnbeaiMOShyrym98/uIf4P8XijlUdgiAEgRK
         OSif/b3Up3cBPNF4KWVxufbMWlTmCF4ppADA2VgC9QJWSpRmeS7IlUBrpu38QdYhOXQ2
         opdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=6kVIFEhxFXj2VwKuP8wNFEI6LlDjARsvOHaqSOLV2+M=;
        b=UBbSUtdMwuum1Jhx7Ou2w9DriHnawrMzZ0+H1Qa7RZ4rA+31S5JDTaA+6fFkC2SJfQ
         pqo8pZQyY+d16JfJLMHezXFfgDUSmvNlVTen2LbL7Ou3WgOoKVhF+av3TgBMJSwmgTLj
         iIFJMCja244OtRM+v+SVklH1GpwAedtFaz/qoEcj6Wdo/OsvzEEhYCTgyfXqWWSfhR3a
         gNycCPUanvUupR9REE3DpLMdQKvlCcaOhWTW6DsFGAlumQ0x5G4TIEu2mJ18MJ8346Fb
         WYlsAe9eEl0KnolVg8lYk1qqvrOFtRneAcgPNtg9Nv2WWEJYlOYjgXErnnNOmkbl6vOs
         cP/Q==
X-Gm-Message-State: APjAAAXdJbSTT3Bkps4/v2sAgask39CCwh59Tww6eDqKfq5DsTyguHtS
        4NPwaoDH1J+Yytv3JNybfjY=
X-Google-Smtp-Source: APXvYqwYhacKllVX4bTxQG5d5i4F4rK+WUJO9AWlUyJ8uE9H+MCDLEVwGZ7ZHazywar1qQ+FRQvznw==
X-Received: by 2002:a0c:d912:: with SMTP id p18mr4498930qvj.158.1567029987865;
        Wed, 28 Aug 2019 15:06:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id o18sm304944qtb.53.2019.08.28.15.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:27 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/10] blkcg: add tools/cgroup/iocost_coef_gen.py
Date:   Wed, 28 Aug 2019 15:06:00 -0700
Message-Id: <20190828220600.2527417-11-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a script which can be used to generate device-specific iocost
linear model coefficients.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |   3 +
 block/blk-iocost.c                      |   3 +
 tools/cgroup/iocost_coef_gen.py         | 178 ++++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 tools/cgroup/iocost_coef_gen.py

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1521c7e554f5..3deacdc5e6d2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1529,6 +1529,9 @@ IO Interface Files
 	The IO cost model isn't expected to be accurate in absolute
 	sense and is scaled to the device behavior dynamically.
 
+	If needed, tools/cgroup/iocost_coef_gen.py can be used to
+	generate device-specific coefficients.
+
   io.weight
 	A read-write flat-keyed file which exists on non-root cgroups.
 	The default is "default 100".
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3208d2fdc55e..f04a4ed1cb45 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -46,6 +46,9 @@
  * If needed, tools/cgroup/iocost_coef_gen.py can be used to generate
  * device-specific coefficients.
  *
+ * If needed, tools/cgroup/iocost_coef_gen.py can be used to generate
+ * device-specific coefficients.
+ *
  * 2. Control Strategy
  *
  * The device virtual time (vtime) is used as the primary control metric.
diff --git a/tools/cgroup/iocost_coef_gen.py b/tools/cgroup/iocost_coef_gen.py
new file mode 100644
index 000000000000..df17a2ae80e5
--- /dev/null
+++ b/tools/cgroup/iocost_coef_gen.py
@@ -0,0 +1,178 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2019 Tejun Heo <tj@kernel.org>
+# Copyright (C) 2019 Andy Newell <newella@fb.com>
+# Copyright (C) 2019 Facebook
+
+desc = """
+Generate linear IO cost model coefficients used by the blk-iocost
+controller.  If the target raw testdev is specified, destructive tests
+are performed against the whole device; otherwise, on
+./iocost-coef-fio.testfile.  The result can be written directly to
+/sys/fs/cgroup/io.cost.model.
+
+On high performance devices, --numjobs > 1 is needed to achieve
+saturation.
+
+See Documentation/admin-guide/cgroup-v2.rst and block/blk-iocost.c
+for more details.
+"""
+
+import argparse
+import re
+import json
+import glob
+import os
+import sys
+import atexit
+import shutil
+import tempfile
+import subprocess
+
+parser = argparse.ArgumentParser(description=desc,
+                                 formatter_class=argparse.RawTextHelpFormatter)
+parser.add_argument('--testdev', metavar='DEV',
+                    help='Raw block device to use for testing, ignores --testfile-size')
+parser.add_argument('--testfile-size-gb', type=float, metavar='GIGABYTES', default=16,
+                    help='Testfile size in gigabytes (default: %(default)s)')
+parser.add_argument('--duration', type=int, metavar='SECONDS', default=120,
+                    help='Individual test run duration in seconds (default: %(default)s)')
+parser.add_argument('--seqio-block-mb', metavar='MEGABYTES', type=int, default=128,
+                    help='Sequential test block size in megabytes (default: %(default)s)')
+parser.add_argument('--seq-depth', type=int, metavar='DEPTH', default=64,
+                    help='Sequential test queue depth (default: %(default)s)')
+parser.add_argument('--rand-depth', type=int, metavar='DEPTH', default=64,
+                    help='Random test queue depth (default: %(default)s)')
+parser.add_argument('--numjobs', type=int, metavar='JOBS', default=1,
+                    help='Number of parallel fio jobs to run (default: %(default)s)')
+parser.add_argument('--quiet', action='store_true')
+parser.add_argument('--verbose', action='store_true')
+
+def info(msg):
+    if not args.quiet:
+        print(msg)
+
+def dbg(msg):
+    if args.verbose and not args.quiet:
+        print(msg)
+
+# determine ('DEVNAME', 'MAJ:MIN') for @path
+def dir_to_dev(path):
+    # find the block device the current directory is on
+    devname = subprocess.run(f'findmnt -nvo SOURCE -T{path}',
+                             stdout=subprocess.PIPE, shell=True).stdout
+    devname = os.path.basename(devname).decode('utf-8').strip()
+
+    # partition -> whole device
+    parents = glob.glob('/sys/block/*/' + devname)
+    if len(parents):
+        devname = os.path.basename(os.path.dirname(parents[0]))
+    rdev = os.stat(f'/dev/{devname}').st_rdev
+    return (devname, f'{os.major(rdev)}:{os.minor(rdev)}')
+
+def create_testfile(path, size):
+    global args
+
+    if os.path.isfile(path) and os.stat(path).st_size == size:
+        return
+
+    info(f'Creating testfile {path}')
+    subprocess.check_call(f'rm -f {path}', shell=True)
+    subprocess.check_call(f'touch {path}', shell=True)
+    subprocess.call(f'chattr +C {path}', shell=True)
+    subprocess.check_call(
+        f'pv -s {size} -pr /dev/urandom {"-q" if args.quiet else ""} | '
+        f'dd of={path} count={size} '
+        f'iflag=count_bytes,fullblock oflag=direct bs=16M status=none',
+        shell=True)
+
+def run_fio(testfile, duration, iotype, iodepth, blocksize, jobs):
+    global args
+
+    eta = 'never' if args.quiet else 'always'
+    outfile = tempfile.NamedTemporaryFile()
+    cmd = (f'fio --direct=1 --ioengine=libaio --name=coef '
+           f'--filename={testfile} --runtime={round(duration)} '
+           f'--readwrite={iotype} --iodepth={iodepth} --blocksize={blocksize} '
+           f'--eta={eta} --output-format json --output={outfile.name} '
+           f'--time_based --numjobs={jobs}')
+    if args.verbose:
+        dbg(f'Running {cmd}')
+    subprocess.check_call(cmd, shell=True)
+    with open(outfile.name, 'r') as f:
+        d = json.loads(f.read())
+    return sum(j['read']['bw_bytes'] + j['write']['bw_bytes'] for j in d['jobs'])
+
+def restore_elevator_nomerges():
+    global elevator_path, nomerges_path, elevator, nomerges
+
+    info(f'Restoring elevator to {elevator} and nomerges to {nomerges}')
+    with open(elevator_path, 'w') as f:
+        f.write(elevator)
+    with open(nomerges_path, 'w') as f:
+        f.write(nomerges)
+
+
+args = parser.parse_args()
+
+missing = False
+for cmd in [ 'findmnt', 'pv', 'dd', 'fio' ]:
+    if not shutil.which(cmd):
+        print(f'Required command "{cmd}" is missing', file=sys.stderr)
+        missing = True
+if missing:
+    sys.exit(1)
+
+if args.testdev:
+    devname = os.path.basename(args.testdev)
+    rdev = os.stat(f'/dev/{devname}').st_rdev
+    devno = f'{os.major(rdev)}:{os.minor(rdev)}'
+    testfile = f'/dev/{devname}'
+    info(f'Test target: {devname}({devno})')
+else:
+    devname, devno = dir_to_dev('.')
+    testfile = 'iocost-coef-fio.testfile'
+    testfile_size = int(args.testfile_size_gb * 2 ** 30)
+    create_testfile(testfile, testfile_size)
+    info(f'Test target: {testfile} on {devname}({devno})')
+
+elevator_path = f'/sys/block/{devname}/queue/scheduler'
+nomerges_path = f'/sys/block/{devname}/queue/nomerges'
+
+with open(elevator_path, 'r') as f:
+    elevator = re.sub(r'.*\[(.*)\].*', r'\1', f.read().strip())
+with open(nomerges_path, 'r') as f:
+    nomerges = f.read().strip()
+
+info(f'Temporarily disabling elevator and merges')
+atexit.register(restore_elevator_nomerges)
+with open(elevator_path, 'w') as f:
+    f.write('none')
+with open(nomerges_path, 'w') as f:
+    f.write('1')
+
+info('Determining rbps...')
+rbps = run_fio(testfile, args.duration, 'read',
+               1, args.seqio_block_mb * (2 ** 20), args.numjobs)
+info(f'\nrbps={rbps}, determining rseqiops...')
+rseqiops = round(run_fio(testfile, args.duration, 'read',
+                         args.seq_depth, 4096, args.numjobs) / 4096)
+info(f'\nrseqiops={rseqiops}, determining rrandiops...')
+rrandiops = round(run_fio(testfile, args.duration, 'randread',
+                          args.rand_depth, 4096, args.numjobs) / 4096)
+info(f'\nrrandiops={rrandiops}, determining wbps...')
+wbps = run_fio(testfile, args.duration, 'write',
+               1, args.seqio_block_mb * (2 ** 20), args.numjobs)
+info(f'\nwbps={wbps}, determining wseqiops...')
+wseqiops = round(run_fio(testfile, args.duration, 'write',
+                         args.seq_depth, 4096, args.numjobs) / 4096)
+info(f'\nwseqiops={wseqiops}, determining wrandiops...')
+wrandiops = round(run_fio(testfile, args.duration, 'randwrite',
+                          args.rand_depth, 4096, args.numjobs) / 4096)
+info(f'\nwrandiops={wrandiops}')
+restore_elevator_nomerges()
+atexit.unregister(restore_elevator_nomerges)
+info('')
+
+print(f'{devno} rbps={rbps} rseqiops={rseqiops} rrandiops={rrandiops} '
+      f'wbps={wbps} wseqiops={wseqiops} wrandiops={wrandiops}')
-- 
2.17.1

