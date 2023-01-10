Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0FF664ED4
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 23:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjAJWed (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 17:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjAJW3E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 17:29:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9442020;
        Tue, 10 Jan 2023 14:29:03 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g68so8163721pgc.11;
        Tue, 10 Jan 2023 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVyTJ4Bvb0dosRz2MzjeXlGvXv4v3QkWAgztM4d7AbQ=;
        b=FoOd0/lpm1Ec2a6lG9I04pjIOWJqT8qMjboF6tzFvFMjGcuBE9LFy0Ej1Q3fBFtKNH
         aWjoY4qnBiG4MrUJCmdWg8uzNOgfic6j8xOZB/eSQ/Jm6CfbPYV+9+qNnir9+rc8w+BX
         ec6VJy4q9I28VKPqm4Kfr6w3MDor6TZoH4qnKfVbYnIsdxBhTkCAVnc9HAXARXG1ROvh
         NC6wqDFifheIYVZSA/hFNwYZeUVFAWRjpDQUam3CtjrS5CZCcD5b4eGIswmFKKnV1vo4
         VQcN+atJhXmqY/80BApmimSASTNjg5FmWGNq1ze986+YezbZV7GIaHrK5H50+5o3nNc1
         X9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVyTJ4Bvb0dosRz2MzjeXlGvXv4v3QkWAgztM4d7AbQ=;
        b=xXvKjgAgGCBxJ63WNWGca9H6mXNoNHqTt4OOEYkbDaHsJ0Jn0L1w8ULlwfllP+FDDu
         6l1lxJ2ilwNVTD30MtCtZgyiKO0fVtvFYz78S7vzZoe/q/LSXU6piNmHGI+wQA/Jozpk
         egvYTDVmE1FvD1Iw3oIqqmvdowQJHYbS3UZ7GfR2XEgG4OQnhFmnMkbV9l65mx0JO96u
         mgzvbAZJzurQnTnyLPAjZLfilxrX8w+FOzXEbTUcm8AMCl0J24ZTHtj7JKSP9afX34f2
         9wXkm4sKHsDiVt5umM2O830US26g+hNUZ2ib0mvsIXZn4zHHoVVCPWGGcQJPqN26SIdt
         ADWA==
X-Gm-Message-State: AFqh2koCyHMJG4lA8Q6z+o+BFuqkV/OYVI+HakINjGgqRhCcIGEoC63o
        RwI1XTq6/iNbxhuTPDeeCs0q8ijSeis=
X-Google-Smtp-Source: AMrXdXsG2OmpeP+NSU8Pdh74qwrh3KDPz0sXs1ijzvD77pu4isIYOkBb2GegiFRMyKr40gfVbJ83fw==
X-Received: by 2002:a05:6a00:194e:b0:58b:6284:779e with SMTP id s14-20020a056a00194e00b0058b6284779emr995724pfk.11.1673389742984;
        Tue, 10 Jan 2023 14:29:02 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f198-20020a6238cf000000b0058b0992f2f9sm1290642pfa.101.2023.01.10.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:29:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Jan 2023 12:29:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: fix a few kernel-doc warnings & coding
 style
Message-ID: <Y73mrfdnjJk2T9bj@slm.duckdns.org>
References: <20230108021217.15491-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108021217.15491-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 07, 2023 at 06:12:17PM -0800, Randy Dunlap wrote:
> Fix kernel-doc notation warnings:
> 
> kernel/cgroup/cpuset.c:1309: warning: Excess function parameter 'cpuset' description in 'update_parent_subparts_cpumask'
> kernel/cgroup/cpuset.c:3909: warning: expecting prototype for cpuset_mem_spread_node(). Prototype was for cpuset_spread_node() instead
> 
> Also drop a blank line before EXPORT_SYMBOL_GPL() to be consistent
> with kernel coding style.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org

Applied to cgroup/for-6.2-fixes.

Thanks.

-- 
tejun
