Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9C3DA384
	for <lists+cgroups@lfdr.de>; Thu, 29 Jul 2021 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhG2M56 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Jul 2021 08:57:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16026 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhG2M56 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Jul 2021 08:57:58 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gb9TX6lyMzZqVV;
        Thu, 29 Jul 2021 20:54:24 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 20:57:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>
CC:     <shakeelb@google.com>, <guro@fb.com>, <willy@infradead.org>,
        <alexs@kernel.org>, <richard.weiyang@gmail.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/5] Cleanups and fixup for memcontrol
Date:   Thu, 29 Jul 2021 20:57:50 +0800
Message-ID: <20210729125755.16871-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,
This series contains cleanups to remove unused functions, narrow the
scope of mutex and so on. Also this fix the possible NULL pointer
dereferencing and possible wrong percpu operation. More details can
be found in the respective changelogs. Thanks!

Miaohe Lin (5):
  mm, memcg: remove unused functions
  mm, memcg: narrow the scope of percpu_charge_mutex
  mm, memcg: save some atomic ops when flush is already true
  mm, memcg: avoid possible NULL pointer dereferencing in
    mem_cgroup_init()
  mm, memcg: always call __mod_node_page_state() with preempt disabled

 include/linux/memcontrol.h | 12 ------------
 mm/memcontrol.c            |  8 +++++---
 2 files changed, 5 insertions(+), 15 deletions(-)

-- 
2.23.0

