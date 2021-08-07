Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED523E3417
	for <lists+cgroups@lfdr.de>; Sat,  7 Aug 2021 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhHGI2z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Aug 2021 04:28:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16059 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhHGI2z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Aug 2021 04:28:55 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ghb4W5l9XzZxqb;
        Sat,  7 Aug 2021 16:24:59 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 16:28:35 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <guro@fb.com>, <songmuchun@bytedance.com>
CC:     <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 0/3] Cleanups and fixup for memcontrol
Date:   Sat, 7 Aug 2021 16:28:32 +0800
Message-ID: <20210807082835.61281-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,
This series contains cleanups to remove unused functions, save some
atomic ops and get rid of unneeded lock. More details can be found
in the respective changelogs. Thanks!

Miaohe Lin (3):
  mm, memcg: remove unused functions
  mm, memcg: save some atomic ops when flush is already true
  mm, memcg: get rid of percpu_charge_mutex lock

v1-->v2:
  drop mm, memcg: avoid possible NULL pointer dereferencing in
mem_cgroup_init()
  drop mm, memcg: always call __mod_node_page_state() with preempt
disabled
  collect Reviewed-by and Acked-by tag
  get rid of percpu_charge_mutex instead of narrowing the scope

 include/linux/memcontrol.h | 12 ------------
 mm/memcontrol.c            |  7 +------
 2 files changed, 1 insertion(+), 18 deletions(-)

-- 
2.23.0

