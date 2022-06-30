Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71145614FB
	for <lists+cgroups@lfdr.de>; Thu, 30 Jun 2022 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiF3I0b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiF3I0N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 04:26:13 -0400
Received: from azure-sdnproxy-1.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 483F7655B;
        Thu, 30 Jun 2022 01:26:02 -0700 (PDT)
Received: from fedora33.wangsu.com (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltACniUYFXr1i9U4BAA--.2324S2;
        Thu, 30 Jun 2022 16:25:51 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linf@wangsu.com
Subject: [PATCH] cgroup-v1: use find granularity format identifiers to make /proc/cgroups show pretty
Date:   Thu, 30 Jun 2022 16:25:39 +0800
Message-Id: <20220630082539.83602-1-linf@wangsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: SyJltACniUYFXr1i9U4BAA--.2324S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy5Zr43Zr4kZw1DGw47CFg_yoW8Gr4xpF
        s8CryFyw45K348Kw12y34v93yrKws7Xw4jg3ZrJ34ayF13A39Fqr1vv3W2qrZYvFWSkF4q
        vFW5Zr4I93WDJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r48McIj6xkF7I0En7xvr7AKxVW8
        Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
        AqYI8I648v4I1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIE
        Y20_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0Jj1MKtUUUUU=
X-CM-SenderInfo: holqwq5zdqw23xof0z/
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The listing subsys info is unaligned with the header columns and we can
make the output more intuitive to read by specifying "left alignment"
and "fixed length" format styles for seq_printf.

# cat /proc/cgroups

the output originally:

#subsys_name	hierarchy	num_cgroups	enabled
cpuset	11	19	1
cpu	5	122	1
cpuacct	5	122	1
blkio	4	122	1
memory	10	129	1
devices	6	122	1
freezer	9	19	1
net_cls	8	19	1
perf_event	3	19	1
net_prio	8	19	1
hugetlb	7	19	1
pids	12	122	1
rdma	2	1	1

output after this patch:

#subsys_name	hierarchy	num_cgroups	enabled
cpuset      	11        	19      	1
cpu         	5         	122     	1
cpuacct     	5         	122     	1
blkio       	4         	122     	1
memory      	10        	129     	1
devices     	6         	122     	1
freezer     	9         	19      	1
net_cls     	8         	19      	1
perf_event  	3         	19      	1
net_prio    	8         	19      	1
hugetlb     	7         	19      	1
pids        	12        	122     	1
rdma        	2         	1       	1

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 kernel/cgroup/cgroup-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index afc6c0e9c966..1a74b0c504aa 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -677,7 +677,7 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	 */
 
 	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
+		seq_printf(m, "%-12s\t%-10d\t%-10d\t%-d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
-- 
2.31.1

