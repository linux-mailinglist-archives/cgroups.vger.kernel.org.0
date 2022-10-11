Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D515FA8E4
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 02:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJKADN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 20:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKADL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 20:03:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298C480504;
        Mon, 10 Oct 2022 17:03:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h185so4427201pgc.10;
        Mon, 10 Oct 2022 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+llQOs1rDUP1s79HRj7eRagiprARX+HG1GAmZurmEA=;
        b=bFHvYCEQLjSfzroDOuLQ9Iu9SAR9bjDwReNKR9N1SoBlWDmZ+SRcBe52uoZWup5vkr
         mSOWD5Le1Sj0AS20ah3a5X5YUWs0Khm3JrUy/4ElGslNB2ryYstN+Q7hOBW1z0FDOr5x
         nnPyXM7UqK7Gs+bel7pTZ2GxXMn6BTKiSVBYKsf2GMunWfpQWiT/aaMLCmvGRZciJCUb
         S+kdQY8YaWhT/c2wMqcE7cscmzsW4pKvYN/uG5qGcHQyySgn4L9CCMVEBjRbLNX7mfZk
         K6jw2UrKqcezN517aTlL7K7gOdnTIr32jkOK8kSba7wokCrMsycBHLxRKP9hLtpO10U5
         Il+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+llQOs1rDUP1s79HRj7eRagiprARX+HG1GAmZurmEA=;
        b=7iAKRt3+ayvuOT2Qimdbm6AV9KFab84xyzyK45XsA//aH7oQHDDtTihUm0KH0SGEpK
         B0tPraQQC8a5uDe/Tp/hiuaRiBPE40RLi0eu3GxG/TrO0lwfdNGJryEieTUeTiWIRKUW
         seamYAMoHbducEiTxoGqtbv+fdEq+iJzNO+b5g/R4qtn0krG+nOS/Fr5l+x3dpA00AtC
         G9y4GaumXuYED26ccERnJvHoicyf5JgJTPycYbF4KXweSonCHIFoMwm/mmOzaeE+r41L
         BTvi9IR4N6U8jotRcYdpgmjTnXPZE/0s77MXK3MvcTlTsEhyRdkXNKAdm9Yuuy12q5UF
         cJeg==
X-Gm-Message-State: ACrzQf10VrvybzYijY3/3wUfEsJK844hzl80OWF50FYOfH0jHAOY/9ZX
        dquFMN8Ro5qYSvXICJcBAEg=
X-Google-Smtp-Source: AMsMyM5NMWylJqWXpz7AzoIykyglnmxpYJOMlu6VMfUrXLfW/UxOxWJGbMhiaqwjgssb9gzOdne/XQ==
X-Received: by 2002:a05:6a00:3392:b0:547:f861:1fad with SMTP id cm18-20020a056a00339200b00547f8611fadmr22376236pfb.16.1665446590528;
        Mon, 10 Oct 2022 17:03:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l76-20020a633e4f000000b00460a5c6304dsm4183661pga.67.2022.10.10.17.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:03:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 14:03:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, "Christian A . Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH v1 1/3] Revert "cgroup: enable cgroup_get_from_file() on
 cgroup1"
Message-ID: <Y0SyvJvzFQOhSFsC@slm.duckdns.org>
References: <20221010235845.3379019-1-yosryahmed@google.com>
 <20221010235845.3379019-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010235845.3379019-2-yosryahmed@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Already queued the following to cgroup/for-6.1-fixes. Will send it out soon.

Thanks.

----- 8< -----
From 03db7716159477b595e9af01be8003b7e994cc79 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 10 Oct 2022 11:08:17 -1000
Subject: [PATCH] Revert "cgroup: enable cgroup_get_from_file() on cgroup1"

This reverts commit f3a2aebdd6fb90e444d595e46de64e822af419da.

The commit enabled looking up v1 cgroups via cgroup_get_from_file().
However, there are multiple users, including CLONE_INTO_CGROUP, which have
been assuming that it would only look up v2 cgroups. Returning v1 cgroups
breaks them.

Let's revert the commit and retry later with a separate lookup interface
which allows both v1 and v2.

Signed-off-by: Tejun Heo <tj@kernel.org>
Link: http://lkml.kernel.org/r/000000000000385cbf05ea3f1862@google.com
Cc: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ecf409e3c3a7..6d8a5a40c24d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6234,6 +6234,11 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 		return ERR_CAST(css);
 
 	cgrp = css->cgroup;
+	if (!cgroup_on_dfl(cgrp)) {
+		cgroup_put(cgrp);
+		return ERR_PTR(-EBADF);
+	}
+
 	return cgrp;
 }
 
-- 
2.37.3
