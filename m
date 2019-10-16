Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06869D84B3
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2019 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbfJPAPS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 20:15:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18556 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388290AbfJPAPR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 20:15:17 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9G08RqJ013135
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2019 17:15:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=piuROuyuLexIgo6YVVV71gK2H3dCOmrH37BJZ+WhLE4=;
 b=IOMWFbguI49f3iQvjtxFW5tLTfLq/bndlCE/ioKXF4NLJjNA0qTWWsZGvZVthc7O9czK
 vjnzu/GECxHxp0rPWAc4AWaHiWS8YFPCQRpt6ZPPfSe3UGhkB/Qy2ZjB9CLNhuTmi4jk
 QN+QX32n8GOLNKdXjvj1CM7rG6QMMPirj9s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vna13v6f7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2019 17:15:16 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Oct 2019 17:15:15 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 6752418B69EE5; Tue, 15 Oct 2019 17:15:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>, Waiman Long <longman@redhat.com>,
        "Tobin C . Harding" <tobin@kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] tools/cgroup: add slabinfo.py tool
Date:   Tue, 15 Oct 2019 17:15:04 -0700
Message-ID: <20191016001504.1099106-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_08:2019-10-15,2019-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910150206
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a drgn-based tool to display slab information for a given memcg.
Can replace cgroup v1 memory.kmem.slabinfo interface on cgroup v2,
but in a more flexiable way.

Currently supports only SLUB configuration, but SLAB can be trivially
added later.

Output example:
$ sudo ./tools/cgroup/slabinfo.py /sys/fs/cgroup/user.slice/user-111017.slice/user\@111017.service
shmem_inode_cache     92     92    704   46    8 : tunables    0    0    0 : slabdata      2      2      0
eventpoll_pwq         56     56     72   56    1 : tunables    0    0    0 : slabdata      1      1      0
eventpoll_epi         32     32    128   32    1 : tunables    0    0    0 : slabdata      1      1      0
kmalloc-8              0      0      8  512    1 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-96             0      0     96   42    1 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-2048           0      0   2048   16    8 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-64           128    128     64   64    1 : tunables    0    0    0 : slabdata      2      2      0
mm_struct            160    160   1024   32    8 : tunables    0    0    0 : slabdata      5      5      0
signal_cache          96     96   1024   32    8 : tunables    0    0    0 : slabdata      3      3      0
sighand_cache         45     45   2112   15    8 : tunables    0    0    0 : slabdata      3      3      0
files_cache          138    138    704   46    8 : tunables    0    0    0 : slabdata      3      3      0
task_delay_info      153    153     80   51    1 : tunables    0    0    0 : slabdata      3      3      0
task_struct           27     27   3520    9    8 : tunables    0    0    0 : slabdata      3      3      0
radix_tree_node       56     56    584   28    4 : tunables    0    0    0 : slabdata      2      2      0
btrfs_inode          140    140   1136   28    8 : tunables    0    0    0 : slabdata      5      5      0
kmalloc-1024          64     64   1024   32    8 : tunables    0    0    0 : slabdata      2      2      0
kmalloc-192           84     84    192   42    2 : tunables    0    0    0 : slabdata      2      2      0
inode_cache           54     54    600   27    4 : tunables    0    0    0 : slabdata      2      2      0
kmalloc-128            0      0    128   32    1 : tunables    0    0    0 : slabdata      0      0      0
kmalloc-512           32     32    512   32    4 : tunables    0    0    0 : slabdata      1      1      0
skbuff_head_cache     32     32    256   32    2 : tunables    0    0    0 : slabdata      1      1      0
sock_inode_cache      46     46    704   46    8 : tunables    0    0    0 : slabdata      1      1      0
cred_jar             378    378    192   42    2 : tunables    0    0    0 : slabdata      9      9      0
proc_inode_cache      96     96    672   24    4 : tunables    0    0    0 : slabdata      4      4      0
dentry               336    336    192   42    2 : tunables    0    0    0 : slabdata      8      8      0
filp                 697    864    256   32    2 : tunables    0    0    0 : slabdata     27     27      0
anon_vma             644    644     88   46    1 : tunables    0    0    0 : slabdata     14     14      0
pid                 1408   1408     64   64    1 : tunables    0    0    0 : slabdata     22     22      0
vm_area_struct      1200   1200    200   40    2 : tunables    0    0    0 : slabdata     30     30      0

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Tobin C. Harding <tobin@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/slabinfo.py | 159 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100755 tools/cgroup/slabinfo.py

diff --git a/tools/cgroup/slabinfo.py b/tools/cgroup/slabinfo.py
new file mode 100755
index 000000000000..40b01a6ec4b0
--- /dev/null
+++ b/tools/cgroup/slabinfo.py
@@ -0,0 +1,159 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2019 Roman Gushchin <guro@fb.com>
+# Copyright (C) 2019 Facebook
+
+from os import stat
+import argparse
+import sys
+
+from drgn.helpers.linux import list_for_each_entry, list_empty
+from drgn import container_of
+
+
+DESC = """
+This is a drgn script to provide slab statistics for memory cgroups.
+It supports cgroup v2 and v1 and can emulate memory.kmem.slabinfo
+interface of cgroup v1.
+For drgn, visit https://github.com/osandov/drgn.
+"""
+
+
+MEMCGS = {}
+
+OO_SHIFT = 16
+OO_MASK = ((1 << OO_SHIFT) - 1)
+
+
+def err(s):
+    print('slabinfo.py: error: %s' % s, file=sys.stderr, flush=True)
+    sys.exit(1)
+
+
+def find_memcg_ids(css=prog['root_mem_cgroup'].css, prefix=''):
+    if not list_empty(css.children.address_of_()):
+        for css in list_for_each_entry('struct cgroup_subsys_state',
+                                       css.children.address_of_(),
+                                       'sibling'):
+            name = prefix + '/' + css.cgroup.kn.name.string_().decode('utf-8')
+            memcg = container_of(css, 'struct mem_cgroup', 'css')
+            MEMCGS[css.cgroup.kn.id.ino.value_()] = memcg
+            find_memcg_ids(css, name)
+
+
+def is_root_cache(s):
+    return False if s.memcg_params.root_cache else True
+
+
+def cache_name(s):
+    if is_root_cache(s):
+        return s.name
+    else:
+        return s.memcg_params.root_cache.name.string_().decode('utf-8')
+
+
+# SLUB
+
+def oo_order(s):
+    return s.oo.x >> OO_SHIFT
+
+
+def oo_objects(s):
+    return s.oo.x & OO_MASK
+
+
+def count_partial(n, fn):
+    nr_pages = 0
+    for page in list_for_each_entry('struct page', n.partial.address_of_(),
+                                    'lru'):
+         nr_pages += fn(page)
+    return nr_pages
+
+
+def count_free(page):
+    return page.objects - page.inuse
+
+
+def slub_get_slabinfo(s, cfg):
+    nr_slabs = 0
+    nr_objs = 0
+    nr_free = 0
+
+    for node in range(cfg['nr_nodes']):
+        n = s.node[node]
+        nr_slabs += n.nr_slabs.counter.value_()
+        nr_objs += n.total_objects.counter.value_()
+        nr_free += count_partial(n, count_free)
+
+    return {'active_objs': nr_objs - nr_free,
+            'num_objs': nr_objs,
+            'active_slabs': nr_slabs,
+            'num_slabs': nr_slabs,
+            'objects_per_slab': oo_objects(s),
+            'cache_order': oo_order(s),
+            'limit': 0,
+            'batchcount': 0,
+            'shared': 0,
+            'shared_avail': 0}
+
+# SLAB-specific functions can be added here...
+
+
+def cache_show(s, cfg):
+    if cfg['allocator'] == 'SLUB':
+        sinfo = slub_get_slabinfo(s, cfg)
+    else:
+        err('SLAB isn\'t supported yet')
+
+    print('%-17s %6lu %6lu %6u %4u %4d'
+          ' : tunables %4u %4u %4u'
+          ' : slabdata %6lu %6lu %6lu' % (
+              cache_name(s), sinfo['active_objs'], sinfo['num_objs'],
+              s.size, sinfo['objects_per_slab'], 1 << sinfo['cache_order'],
+              sinfo['limit'], sinfo['batchcount'], sinfo['shared'],
+              sinfo['active_slabs'], sinfo['num_slabs'],
+              sinfo['shared_avail']))
+
+
+def detect_kernel_config():
+    cfg = {}
+
+    cfg['nr_nodes'] = prog['nr_online_nodes'].value_()
+
+    if prog.type('struct kmem_cache').members[1][1] == 'flags':
+        cfg['allocator'] = 'SLUB'
+    elif prog.type('struct kmem_cache').members[1][1] == 'batchcount':
+        cfg['allocator'] = 'SLAB'
+    else:
+        err('Can\'t determine the slab allocator')
+
+    return cfg
+
+
+def main():
+    parser = argparse.ArgumentParser(description=DESC,
+                                     formatter_class=argparse.RawTextHelpFormatter)
+    parser.add_argument('cgroup', metavar='CGROUP',
+                        help='Target memory cgroup')
+    args = parser.parse_args()
+
+    try:
+        cgroup_id = stat(args.cgroup).st_ino
+        find_memcg_ids()
+        memcg = MEMCGS[cgroup_id]
+    except KeyError:
+        err('Can\'t find the memory cgroup')
+
+    cfg = detect_kernel_config()
+
+    print('# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>'
+          ' : tunables <limit> <batchcount> <sharedfactor>'
+          ' : slabdata <active_slabs> <num_slabs> <sharedavail>')
+
+    for s in list_for_each_entry('struct kmem_cache',
+                                 memcg.kmem_caches.address_of_(),
+                                 'memcg_params.kmem_caches_node'):
+        cache_show(s, cfg)
+
+
+main()
-- 
2.17.1

