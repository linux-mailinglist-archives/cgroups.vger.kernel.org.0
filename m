Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83675D11D
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 20:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGUSL5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 14:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUSL5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 14:11:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA3E68;
        Fri, 21 Jul 2023 11:11:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad907ba4so13595975ad.0;
        Fri, 21 Jul 2023 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689963115; x=1690567915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRtzlaHKzDk5tTi7aUgo8xmfyZYu4TD/4asfXW62u9M=;
        b=KG4z0SDNckHDGHzSeIhkND6qLoO8j5teBq6VpviRqg16Aj72e032nyb3O5B1pcvnIe
         WQ/o2T8nisvb9FYRrcZUxk2uivwBX8j3qs4NzHXyTXiJ8vAW4jwsQWW57215tAVy+gaB
         dQEGPd9TDAANVz3UGOCGHlGa+sUBl8BeQQEeUpOylgn+/ScVw3HLLzDwJmW5KBJz6J2D
         oHv4WmXpWWzjUOZiegR5cF46pCFz9WqkduAoAwm81JD1qNOtaKp+y+icQQF8MJV1TgXj
         cUB3xJXt6jcTR0NjBetioKDiASPLDgIL4O1BngVJEsV9qyGtie4nGK0Cy9GWSnAbkU9i
         0r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963115; x=1690567915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRtzlaHKzDk5tTi7aUgo8xmfyZYu4TD/4asfXW62u9M=;
        b=F/zUNI0KJfuYsi5TTvTw5VaANOwQp3TkCkv2gfv/FKLZEye9oN1tcvzPty0GbJNkMr
         8Q8Q6sLwlhkoE1A5+3aeE+te5MVAopEHiEmzCl5rh4RJ/T58D53l73AdNXxBRUHo2xOo
         wkF3ZSDO6DhQMZ9RTxjwpHw4oUcCXeS++zt+EHVdvuE5XMz2dWHQlRH/wpYCvPeUYS5l
         eoyCGw9YXWZXZTnWRQ6W9gpAbpLgYLwh1WeNhY0Asl/1DiD1E4UG2MEpyIi6kkGOwDIK
         iCfuh8A2yO8e5oE6NjS8oxM8ljpd4pWu3Ljg2yyAFgpEJr8oluvSGksJvt1bb37PA6ES
         /6qg==
X-Gm-Message-State: ABy/qLa8utQtMfGqMrJn8nHppKPcOwj01CRS3jbH5eRuQO2yVg1vLd85
        omKAZc51Ws5uWimpcvYo31M=
X-Google-Smtp-Source: APBJJlEc1Xn2cZSlLsIG6kKY+QtZIddos0jsfE2fn81u9tzFt8rm017ySi6BdhhEk0OfNsaObgW5qQ==
X-Received: by 2002:a17:902:70cc:b0:1b9:cb27:7f43 with SMTP id l12-20020a17090270cc00b001b9cb277f43mr2031685plt.43.1689963115113;
        Fri, 21 Jul 2023 11:11:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001b9e82a6be7sm3804386pli.220.2023.07.21.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:11:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 08:11:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     xiongwei.song@windriver.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: cgroup-v1: fix typo
Message-ID: <ZLrKaYfn1qoWm5XM@slm.duckdns.org>
References: <20230721054938.1666475-1-xiongwei.song@windriver.com>
 <20230721054938.1666475-2-xiongwei.song@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721054938.1666475-2-xiongwei.song@windriver.com>
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

On Fri, Jul 21, 2023 at 01:49:38PM +0800, xiongwei.song@windriver.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> "listers" -> "listeners"
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Applied 1-2 to cgroup/for-6.6.

Thanks.

-- 
tejun
