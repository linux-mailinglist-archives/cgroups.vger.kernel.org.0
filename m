Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC875B863
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 21:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGTT7o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 15:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTT7n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 15:59:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0891BE2;
        Thu, 20 Jul 2023 12:59:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666ecf9a081so1038090b3a.2;
        Thu, 20 Jul 2023 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883179; x=1690487979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpeVGMhDTTLTNxyLLa2NKiBDsv0lT8EhjxwFV8Gr564=;
        b=EDWl9x9JvIOHXr/ppBs9v45am5RKoK6X0M5l44abzq0D1tr8D8PIkNwZeC/PqSi6WH
         YD3n+GNQRZy8Gi+yCC205qQi85U+E1oUyb8+RvY/JE0aMdjfi6epzsirkOam66+9jB/m
         99uSEzozms/v79GnfGNSXzCytVjnuX/RTCZk+xPaDB1GyaEHYuNCzL/WzDXXdwkAXcs5
         f2AiluX6q+j/emZ4IwVLbwa3tT6JqKJCrJX/ESblrMBLO5r/lr4GAKz/OD2fglW8t1le
         bWS6GchQrRTZ2Rzua3+4e5vDWdYHKGfITIh496bFSs13I2xEK3MjSbSkm1NZB5ARk4Tc
         jsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883179; x=1690487979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpeVGMhDTTLTNxyLLa2NKiBDsv0lT8EhjxwFV8Gr564=;
        b=d2KOszQuPpebBKdK/BjrLE3286mcJDayA0EwHAirATbJcmrf49oAjbawH0QJmxv/iN
         XJ8mKXyJfnAZhYwo991SFXo5Bc/E4JXhM6Soq9pHxCygUjafHYiAbZsSoQAbb/PO38ox
         jAFNEMdQDTL8F3HJUuBH/YcqY3//ILnx6/mNto7m5lPdMGyWYSQwmqR7qe0eHH+pW3mv
         vzEYcj7GjcantrKn8bgig6W0PtmjyZY1mHcXMqyuElMS/Fop7mVEcepK6KENtcOMRuGK
         bo1LE/+N4a4XIrpXbu9B39H2jibsrm6EPuT4iKeFUGKsanTABnLU60wkg0cQY7Ydko6u
         5/7A==
X-Gm-Message-State: ABy/qLYLi99bWn4lNfsPWKIF/TlBIO86WfSVzkxuGiy24rADA9YR/l77
        VijaJXigUL6KrFLzZgbeHh0=
X-Google-Smtp-Source: APBJJlHcLupOt7KHNIGlzbYgALPp13j7zdxBLtipHDt5sfyesKFDTOSyJc46zww2Hy8bSJ3qU2k+kA==
X-Received: by 2002:a05:6a20:491:b0:137:2204:4ea6 with SMTP id 17-20020a056a20049100b0013722044ea6mr153159pzc.27.1689883178825;
        Thu, 20 Jul 2023 12:59:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79256000000b0068338b6667asm1528056pfp.212.2023.07.20.12.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:59:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Jul 2023 09:59:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH] blk-iocost: skip empty flush bio in iocost
Message-ID: <ZLmSKdW5wTx0dAlz@slm.duckdns.org>
References: <20230720121441.1408522-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720121441.1408522-1-chengming.zhou@linux.dev>
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

On Thu, Jul 20, 2023 at 08:14:41PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The flush bio may have data, may have no data (empty flush), we couldn't
> calculate cost for empty flush bio. So we'd better just skip it for now.
> 
> Another side effect is that empty flush bio's bio_end_sector() is 0, cause
> iocg->cursor reset to 0, may break the cost calculation of other bios.
> 
> This isn't good enough, since flush bio still consume the device bandwidth,
> but flush request is special, can be merged randomly in the flush state
> machine, we don't know how to calculate cost for it for now.
> 
> Its completion time also has flaws, which may include the pre-flush or
> post-flush completion time, but I don't know if we need to fix that and
> how to fix it.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

It's unlikely that this will change behaviors in an observable way in most
cases. That said, yeah, ignoring it in terms of cost calculation is likely
the better thing to do.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
