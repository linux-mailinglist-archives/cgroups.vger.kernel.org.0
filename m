Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1BE561892
	for <lists+cgroups@lfdr.de>; Thu, 30 Jun 2022 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiF3Kwe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jun 2022 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiF3KwZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jun 2022 06:52:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F438181;
        Thu, 30 Jun 2022 03:52:17 -0700 (PDT)
X-UUID: 5ade9aec18a844b9bf34d19669efdc4c-20220630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:2fb03b3d-f589-47bb-b35a-bfe5ff64c847,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:87442a2,CLOUDID:d9850f63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 5ade9aec18a844b9bf34d19669efdc4c-20220630
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1588602314; Thu, 30 Jun 2022 18:52:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 30 Jun 2022 18:52:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 30 Jun 2022 18:52:11 +0800
Message-ID: <1978e209e71905d89651e61abd07285912d412a1.camel@mediatek.com>
Subject: [Bug] race condition at rebind_subsystems()
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        <wsd_upstream@mediatek.com>, <lixiong.liu@mediatek.com>,
        <wenju.xu@mediatek.com>, <jonathan.jmchen@mediatek.com>
Date:   Thu, 30 Jun 2022 18:52:10 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes



We find the KE(kernel exception) happened when test the reboot test
case in T SW version with kernel-5.15.
The issue is unable to handle kernel paging request at virtual address.

Root cause:
The rebind_subsystems() is no lock held when move css object from A
list to B list,then let B's head be treated as css node at
list_for_each_entry_rcu().
Use the wrong css to get css->ss->css_rstat_flush should get a wrong
address.

The call stack as following:
kthread
-> worker_thread
-> process_one_work
-> flush_memcg_stats_dwork
-> __mem_cgroup_flush_stats
-> cgroup_rstat_flush_irqsafe
-> cgroup_rstat_flush_locked

Detail:
static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool
may_sleep)
{
...
   rcu_read_lock();
   list_for_each_entry_rcu(css, &pos->rstat_css_list,
                             rstat_css_node)
        css->ss->css_rstat_flush(css, cpu);
   rcu_read_unlock();
...
}

Because the content of css->ss is not a function address,
once the css_rstat_flush is called, kernel exception will happen.
When the issue happened, the list of pos->rstat_css_list at group A is
empty.
There must be racing conditions.

From reviewing code, we find rebind_subsystems() is no lock held when
move css object to other list.

int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
{
...
   if (ss->css_rstat_flush) {
         list_del_rcu(&css->rstat_css_node);
         list_add_rcu(&css->rstat_css_node,
                      &dcgrp->rstat_css_list);
   }
...
}

If we held a css object from A group list, at same time this css object
was moved to B group list.
Because current pos is in B’s list, link list was link the pos->next to
B’s head, so the pos->member will never equal A’s head, then the B’s
head(cgroup_root->cgroup->rstat_css_list) will be treated as css
node(css->rstat_css_node).
list_for_each_entry_rcu() use the container_of() to get css address,
and it treated the address of [cgroup_root->cgroup->rstat_css_list -
rstat_css_node] to be a css address.
cgroup_rstat_flush_locked() use the wrong css address to do css->ss-
>css_rstat_flush, then the wrong function address will be jump.

#define list_for_each_entry_rcu(pos, head, member,
cond...)             \
   for (__list_check_rcu(dummy, ## cond, 0), \
     pos = list_entry_rcu((head)->next, typeof(*pos), member); \
        &pos->member != (head);                                \
        pos = list_entry_rcu(pos->member.next, typeof(*pos), member))


We look the patch of move css object from A list to B list is merged by
following link:

https://android.googlesource.com/kernel/common/+/a7df69b81aac5bdeb5c5aef9addd680ce22feebf%5E%21/#F0


Do you have any suggestion for this issue?
Thank you.



Best Regards,
Jing-Ting Wu


