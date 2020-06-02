Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825791EB382
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2020 04:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFBCv0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jun 2020 22:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgFBCvY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jun 2020 22:51:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47466C061A0E;
        Mon,  1 Jun 2020 19:51:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v79so11176547qkb.10;
        Mon, 01 Jun 2020 19:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=leA9A2lWOCRo5ss9zbN0lzkpnk/eM2vdFVHyb+2f+v0=;
        b=pRjoaZeGVVDZdZ5GWQw4vFjByobFIF0+lPxKdVstS+U0OM3oIN6NyH//pOnbbZeMY1
         VCfdRrevrdEjqgQchsrpsmwMs2K+HIcp5g3INLlzoN0VW1S+AVFwG7ejkWwzix7oVl+u
         aWsTSQ3AOgviNQA1/S8wds2jVzteuoGb5Rw+UcLCqg6OWP7DTGRUenCfhvM6/H5l0ciW
         Asj6qqIOK9rOUMHLeem5gBDmOcLlFmb8LX/7VxcDUdFHmrbMsrYK+tL4T2c9nNgzsGAh
         HXXMQey81V2PtOMRWigYxG/N9qPYwjSUgDOrz2YLLu06lvcA51JhEebaIdhPD+3aF5ia
         alyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=leA9A2lWOCRo5ss9zbN0lzkpnk/eM2vdFVHyb+2f+v0=;
        b=aaEV6pYeSIGA0uGW4vU55X9RgarKaN0fV7aA88rXf3SE/yHq/2ZCx65IfRZo43RIgM
         YcgMYFB59JAxXn2hLZY3POzW0jbm4Z8jCbS2vB32PxWeDMhtzEEC459U4MKJd9Ahxrjl
         mQu1yYJL1i7JTerwBp0pXOTfrxTv93zKvtFVMz2juWMaThWfNFL0qjtTpHuUCZHqVqaZ
         f72UEwDhg6qRx2GrbZ6m9J0r5cHc2/tDqRirBRVzkSvVRfqZ1FF/wnJYHzCt3HU0y3d7
         SQqWUYUrS3bcl7Z3zgGg3ZTeIm5UK3EH9UwXLyHK6IGANXzDQQHspBnhRZDmwcObhREU
         iFxw==
X-Gm-Message-State: AOAM533n+QLKLnV6mb7c8pDJInKICPmveRaN8Zw1ecV7FVnieBBz6Vwy
        F5HRvwNriD8wgWE3l4KQkVY=
X-Google-Smtp-Source: ABdhPJyoyCkJmPida7PjZzzGMpFJ2QXHvg/CL+zYbFZBVcDTTgm0jiFZuXJ0qQ0fw6yh77O4oUWuRw==
X-Received: by 2002:a37:8187:: with SMTP id c129mr22705414qkd.211.1591066283190;
        Mon, 01 Jun 2020 19:51:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id s201sm1387764qka.8.2020.06.01.19.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 19:51:22 -0700 (PDT)
Date:   Mon, 1 Jun 2020 22:51:21 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] blk-cgroup: don't account iostat for root cgroup
Message-ID: <20200602025121.GG31548@mtj.thefacebook.com>
References: <20200601231141.2218370-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601231141.2218370-1-boris@bur.io>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 01, 2020 at 04:11:41PM -0700, Boris Burkov wrote:
> This data is never flushed by rstat, so it is never used. We shouldn't
> bother collecting it. We can access global disk stats to compute io
> statistics for the root cgroup.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
