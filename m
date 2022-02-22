Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71E4BEE85
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 02:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiBVA6s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 19:58:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbiBVA6r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 19:58:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B1FEBD
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 16:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8esseIxDpLtfYeuDOxlgY2S2IYHgIucCVCH5cskkgTA=; b=e8GRw2szGsP7BHFrxqnu8hgp0U
        eHuIFbnwm1NqL4cQmzR+z+YyWME7r9ni5PhqX4+kq/MgbvpdBh0J9Pr3pid8yVd+scwjJ6lr2hjwL
        p+QL4WRESqpCExgkZXPYDElcbTO6C6FDDfhTJWyWdV0SWmaafdf/MkVakntciclj0fCS+XhjoL8kH
        3FezNFiDO7YqM6Z6zUcPUGaWGlJjxWM0t8QhwAyaId0XSJtsVb5t1qyapLViB/xfcZZBOvUotY9ng
        eBaEb3sWRU+5ofLBZiibMbLNXfUm4GwfDSqyT340kY/GJUXO/e4zAxJylnpXZ7hWW36NgRMTGTLGw
        BuIG9AEA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMJVM-007Ybe-IH; Tue, 22 Feb 2022 00:58:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-mm@kvack.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
Subject: [PATCH 1/2] mm/memcontrol: return 1 from cgroup.memory __setup() handler
Date:   Mon, 21 Feb 2022 16:58:11 -0800
Message-Id: <20220222005811.10672-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

__setup() handlers should return 1 if the command line option is handled
and 0 if not (or maybe never return 0; it just pollutes init's environment).

The only reason that this particular __setup handler does not pollute
init's environment is that the setup string contains a '.', as in
"cgroup.memory". This causes init/main.c::unknown_boottoption() to
consider it to be an "Unused module parameter" and ignore it. (This is
for parsing of loadable module parameters any time after kernel init.)
Otherwise the string "cgroup.memory=whatever" would be added to init's
environment strings.

Instead of relying on this '.' quirk, just return 1 to indicate that
the boot option has been handled.

Note that there is no warning message if someone enters:
	cgroup.memory=anything_invalid

Fixes: f7e1cb6ec51b0 ("mm: memcontrol: account socket memory in unified hierarchy memory controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: cgroups@vger.kernel.org
---
 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220217.orig/mm/memcontrol.c
+++ linux-next-20220217/mm/memcontrol.c
@@ -7044,7 +7044,7 @@ static int __init cgroup_memory(char *s)
 		if (!strcmp(token, "nokmem"))
 			cgroup_memory_nokmem = true;
 	}
-	return 0;
+	return 1;
 }
 __setup("cgroup.memory=", cgroup_memory);
 
