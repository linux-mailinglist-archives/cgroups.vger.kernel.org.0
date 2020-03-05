Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456BF17B060
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 22:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCEVQw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 16:16:52 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48691 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgCEVQw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 16:16:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4298121F40;
        Thu,  5 Mar 2020 16:16:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 05 Mar 2020 16:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=ux2TDbebxuteV
        tSjPdu5QbynJeWd1LoiKrJmNCdzdIM=; b=GPK4Fjmyow4b3ce4kYCAUlYC8pM5w
        S6doYRhglZqqqTQ8e4SnwlqC72XpMG+wH5+g5fvKILm4d7P1x/8qzwnFkO7fATxY
        XSCCKQkYuU3QjUtEIxXyAKsLC8y49lD8Vc7n+4hosNaaMHby6nZ1cEzEiZNleRWp
        VExbaKmXKBtyDsRpn8M2zyhjyDbzQsPK1SYYga+5Q4G/ONgN/2er1ZghXm25CdJz
        B/66CVk1f8VmlSEBowHV33Ij3+OrzVLxz7Eo6RLwj3HYZpy7xyaGa8zX/hUBAK/e
        Zljcpt/lXRiO5GGxOGz498ePOhomk3Qb4CEO2MHasA6YUdQo8iZRLLxQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ux2TDbebxuteVtSjPdu5QbynJeWd1LoiKrJmNCdzdIM=; b=OahLzm5/
        l9ZomGwWpevlziasrzFQPQc80mfo6qhSO7nvBJZ5IFXZomkMr/qbAdybc2RspJwl
        Sk5X4YwkQhBS3ulFV/cZKr2mGxNd5jgSmKUdyfS3/CTL/vGqlWBzWdNUNubFO58t
        P35KYmtKQXPjLsiw4TBCvjEi424qD2w7JDThS1VFTmhULS7qqI0g5yiF9AyBQTdn
        0a3SWYmxS9i8XY1rLtlEV9OjmzwXOnZKHZO/u4qULhr9ttZT73hL7RYk7UN295YX
        CWT9OYqxheGNH/ERun/QIzFbQiTbLpqp9rD9jnpD3t15RiI9fvYilLVhmJ0WomFU
        19CjkzIqH81BdQ==
X-ME-Sender: <xms:Q2xhXuV2a3N_B0OggwZ6iw2jf5JvplN8c2PSw-bqG6biO01GVbuFHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddutddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrddunecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:Q2xhXu1S1IMO0bo1c-_kkm4rlsJeJeVlaDuDiT53cedq0sJA5lfmHQ>
    <xmx:Q2xhXtYpD57rIzzNPwle85mdXLIVGVypjdFqXx3b861fE9vKpxk5TQ>
    <xmx:Q2xhXpodUiASAQWEEKv4maih-7tg-kpP9FEZFjmD8n7Bd6lg2Z04_g>
    <xmx:Q2xhXpv5VWyEdZyvqfmv6ARa62Fyr1EoX9acD1W2PZMlCfW-NRxzlg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 185A5306075F;
        Thu,  5 Mar 2020 16:16:50 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
Date:   Thu,  5 Mar 2020 13:16:29 -0800
Message-Id: <20200305211632.15369-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305211632.15369-1-dxu@dxuuu.xyz>
References: <20200305211632.15369-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It's not really necessary to have contiguous physical memory for xattr
values. We no longer need to worry about higher order allocations
failing with kvmalloc, especially because the xattr size limit is at
64K.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..0d3c9b4d1914 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	if (len < sizeof(*new_xattr))
 		return NULL;
 
-	new_xattr = kmalloc(len, GFP_KERNEL);
+	new_xattr = kvmalloc(len, GFP_KERNEL);
 	if (!new_xattr)
 		return NULL;
 
@@ -882,7 +882,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 
 		new_xattr->name = kstrdup(name, GFP_KERNEL);
 		if (!new_xattr->name) {
-			kfree(new_xattr);
+			kvfree(new_xattr);
 			return -ENOMEM;
 		}
 	}
@@ -912,7 +912,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 	spin_unlock(&xattrs->lock);
 	if (xattr) {
 		kfree(xattr->name);
-		kfree(xattr);
+		kvfree(xattr);
 	}
 	return err;
 
-- 
2.21.1

