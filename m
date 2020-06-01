Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EEF1EB058
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2020 22:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAUlm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jun 2020 16:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFAUlm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jun 2020 16:41:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB557C061A0E;
        Mon,  1 Jun 2020 13:41:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so8841429qtv.12;
        Mon, 01 Jun 2020 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+uLUR36iZwv1+/Dy3Hfm2UrEbVl2bjczRKyy90BPpE=;
        b=PWCHMPP/FMEx/I6GfNxXPPjzAYeuBQTx5FtXEpVtAugYbaMmDu89qqiS35elSTan33
         lit9wYr60A6K+ISfwBfB5Y2SKX23e1iD8DnwH7ORwmRE/5fhavh2x57MLYGpxZzZscRH
         Dnl9vnY4akko5HRMggp3kFPv9qN8xf3dpAfbmxQEQbzsSmnCiu4+966ndpGoY3PSbLZt
         ihXY0wjzgzPuj63KUraYWKx7EXymXdJSPVZ4UqNsvdDNVvTd2lzTEXoH/ZlGiZ5dRKnL
         TxaooD4sfamdU+TvyW9E/dFQ/zOdmI00zhe+d4mXfDeTPgm1TbqWSjPK9htLsKRCQPOn
         SXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=L+uLUR36iZwv1+/Dy3Hfm2UrEbVl2bjczRKyy90BPpE=;
        b=XiC+WB+MlIpZuYYESG2Br+q38Apbp9DNsd1/3RQBkpmWXlthbxTO+HzjQ4xFLPlHyh
         epP1oidenEOeuiyp5l/508OqnQLZa18ph6dnAhHKFkEfyLF6RCmrlt42REDMuBF67dHf
         M6AZ5koJ0gwE1xfPEooBSjfFKXh2YCLYkbZ+D919MSmzVPgMPAQzT5XTRTDzzyI2VJzK
         2PJr+Ww+WLJYrEK+LZt/MsizHMX2qZXtU+9MP1kX3Z/57UgIhdCO8NpqDH5yMoEdfBRl
         BCB8YsnqRrstE8HwZYTnLKs414Qeh1IM+dSUZImR+tUhgvZQA0l8jqa62VzoLKo5EeW1
         TkHA==
X-Gm-Message-State: AOAM531KO2XkvMia70UXa3xS76G/XxsnF5pViouoMrENxu9H7E65kDu2
        UZvUhUqx6SQbowljNS2RB+s=
X-Google-Smtp-Source: ABdhPJzQbUEqkFEmiFfh8KcdmGtpQNqlLRj6qcQXNgbYHXS3zOVnwGfWgZspy18hDqATF2iV5kS4mw==
X-Received: by 2002:ac8:2492:: with SMTP id s18mr23497170qts.81.1591044099697;
        Mon, 01 Jun 2020 13:41:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id w10sm475193qtc.15.2020.06.01.13.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:41:39 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:41:37 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2 blk-cgroup/for-5.8] blk-cgroup: make iostat functions
 visible to stat printing
Message-ID: <20200601204137.GE31548@mtj.thefacebook.com>
References: <20200601154351.GD31548@mtj.thefacebook.com>
 <20200601201143.1657414-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601201143.1657414-1-boris@bur.io>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 01, 2020 at 01:11:43PM -0700, Boris Burkov wrote:
> Previously, the code which printed io.stat only needed access to the
> generic rstat flushing code, but since we plan to write some more
> specific code for preparing root cgroup stats, we need to manipulate
> iostat structs directly. Since declaring static functions ahead does not
> seem like common practice in this file, simply move the iostat functions
> up. We only plan to use blkg_iostat_set, but it seems better to keep them
> all together.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
