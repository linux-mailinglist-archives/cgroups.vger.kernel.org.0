Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6F54EA35
	for <lists+cgroups@lfdr.de>; Thu, 16 Jun 2022 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378353AbiFPTfO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jun 2022 15:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377357AbiFPTfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jun 2022 15:35:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9145C57B01;
        Thu, 16 Jun 2022 12:35:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z14so2154568pgh.0;
        Thu, 16 Jun 2022 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a4KSlJmtWZkjiLfN9g3so1P7qbrnH5UxDi6TOibKZrg=;
        b=pTI+QTB9FI8Yf2Lnf49gZQgDsuzRXp2tqdWSqdZaO3ef+cvD0oHeUJiaZ+6C2Pve3y
         gEJ3Q3vGopGnx8wzqSe8eBoEej89TmAy4RS9Lir82ibduS4MvW6pMe0UjsHPebCh4Na9
         6QvGYjrJ8B7zmkZap+DXhQF4/62bkYyQLchUis/jHLymP8zQtjbnluu5K+weZ0uoZNdm
         dLo9r45NKoe4TD/1MECXonhVHlYDqLag4sD7UGLzttnJk+tTt7XO9nf8clTh0wCXbPIN
         RjpZC1h8LlUbKx2i4Awvn1E1q+0F4+nRsrNuhYE6ylsPjIMnTJbgupQkSYuJTCKPdN9n
         EtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a4KSlJmtWZkjiLfN9g3so1P7qbrnH5UxDi6TOibKZrg=;
        b=UyD2ZfN17HCHVXM3mULyWdhuTl5ZEfFThp8iyA1fmh4APktk7USmuFnj2bK4T4LRQK
         yQ3uVl2JhMJLvnNOo9TiQyoWEhyBuhp5zeqdicUFo4jkjVwjXUz3otAbVbfuXJQBq8YT
         nx8rMg1NnhBhtyBRc1pB/73h6Rivsay+gbIfwh8e6ZAu5Pq7e7yvss+mPuDNWBL32zUC
         AWYsOJLOu+CWn47sSJKlgK7S/SHOjmKluhzeSJsvP1+W1WFLIepHJZJvvK+3S3ke2U9j
         3rrTUUpqTi7nNYtNB3uesutR/e7rOYa25MwcFG6ID9WaB8ST8xKNJftQkJ3c0Vf8k6H6
         M3xA==
X-Gm-Message-State: AJIora9290hgLWnLiKgo7T68qAmHX+IUNa06CN/fzsp0yEnr5g/cc+sI
        lJdlNKS12Jm91r9QrLDl07Q=
X-Google-Smtp-Source: AGRyM1sGCAwL+H4L4Br2Fey7tXGFqw+O7li6846XUkvrmrgcUemMR8GH8Q8jlAlv32fUzMcTYf7xQQ==
X-Received: by 2002:a63:87c3:0:b0:401:eaf0:ff18 with SMTP id i186-20020a6387c3000000b00401eaf0ff18mr5866531pge.153.1655408111909;
        Thu, 16 Jun 2022 12:35:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:330c])
        by smtp.gmail.com with ESMTPSA id c9-20020a63a409000000b003faf4acac63sm2162064pgf.13.2022.06.16.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 12:35:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 16 Jun 2022 09:35:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup.c: add helper __cset_cgroup_from_root to cleanup
 duplicated codes
Message-ID: <YquF7TzuCjqP8aGZ@slm.duckdns.org>
References: <20220616103830.197458-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616103830.197458-1-linf@wangsu.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 16, 2022 at 06:38:30PM +0800, Lin Feng wrote:
> No funtionality change, but save us some lines.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>

Applied to cgroup/for-5.20.

Thanks.

-- 
tejun
