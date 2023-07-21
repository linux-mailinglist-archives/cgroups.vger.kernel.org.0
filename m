Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DAD75D53F
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjGUTzS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUTzR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 15:55:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA92D7F;
        Fri, 21 Jul 2023 12:55:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb775625e2so2689835ad.1;
        Fri, 21 Jul 2023 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689969316; x=1690574116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngS40wnJU6Nz9N58o+ae3RDY44wKRgOxGzApMOm7Pwo=;
        b=PqYaWRMTzF3Y28/FcPMachG4wI9LhwSaZoXAt9+dCQR7Eba996f6aZpcjo53JTvgSo
         sirafyLQw1T4DX2Nk5CzOyv0Zc0dxfg1NHI0blSN+8pydPzX54e3goFR3VkYC34KQasG
         lRVN2tZiUm1nEErmjkbZdtakLrmehiIQVaet4xSt0C7jB5/9z30Ab0A220xse6jKj0wF
         G7kVEMstTVdyRFAiWURMN2HV/0OmDxIbZ94gFR/BjgMI9yXjc4jJuXbp0w/KoYtcZbjn
         z16S3q86/Ka7KoCoIncxmSFH65UqpzO5YT9d1sf4pjaHgocJIr7UJbaJmx57jvcnYDdE
         p0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689969316; x=1690574116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngS40wnJU6Nz9N58o+ae3RDY44wKRgOxGzApMOm7Pwo=;
        b=NjXswev8eR6LJVBEht9uT7394cZQVTkBbkQbYx4ZmBLjwxTLYoGz7F3qhJHr2J/csf
         ULlabvUsRt/GzIWjLjWfzVPiKBXCUqlsWb94loHwPh6EMQZRlU6DFLNJ7KdAxg0Qg6vx
         Kk8h0DWRPvX0GhohXrKGQ9HNdmoYgMFLJvBZPSiLAQ98s6ZPnuFtqOcZ/KxC1Y4I5kHB
         qXHWt0tWO1O4povYPmqlsi9chGxWUr3VKnr83eDYmIQJJzdGXRhkZt522n3tT5LZzQky
         6Mf3PzIjs8hlSs3H1nXalnVWx21PejYS7SKrs/DB12xbP3h2GFmCx8SiirOkbBInaGmW
         ouRQ==
X-Gm-Message-State: ABy/qLYsdgQ7x8+qKkh5bf/KaksRHQ9YyIZFgjRWZUfunCJrR7wioIqk
        YG0r8yBzdTlr18xCvqoumNg=
X-Google-Smtp-Source: APBJJlErzovmsX/LYGzivsbX3mhrtu9UOUsBIGgcglgQxGIKzIAavr1VtdGdSwYWx41zRdNoz5F6aw==
X-Received: by 2002:a17:902:650e:b0:1b8:a894:407c with SMTP id b14-20020a170902650e00b001b8a894407cmr4744783plk.22.1689969315941;
        Fri, 21 Jul 2023 12:55:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e80d00b001b87d3e845bsm3900263plg.149.2023.07.21.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:55:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 09:55:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix obsolete comment above cgroup_create()
Message-ID: <ZLrioiCmugdroXGJ@slm.duckdns.org>
References: <20230719090640.2568600-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719090640.2568600-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 19, 2023 at 05:06:40PM +0800, Miaohe Lin wrote:
> Since commit 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID"),
> cgrp is associated with its kernfs_node. Update corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
