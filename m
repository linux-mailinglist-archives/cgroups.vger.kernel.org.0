Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02AC2618CA
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgIHSDJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbgIHSDH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 14:03:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA05C061573;
        Tue,  8 Sep 2020 11:03:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so3388485qtp.13;
        Tue, 08 Sep 2020 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9mmDYx8WrU8rvHetKafuDvQNZNEWur0WVQdCgfEZspw=;
        b=SPoVuP8Q6WzCw4D9NfkuXnNEptqRql+J4fajBqQc2kYsIhfgOYk0tEnacAbvowX1iH
         2HgdyOoKtpvck6By0pNhFJcCOunkqWjl1JRzB0GS2+WGlkYvhTBUzobypXqZwLPOYibT
         xt8Zl3up/YriK4ErSIiCCMeyzZTRfS3d4j3xIaFGJZbVBrYfKR4wOZkZXYMQ1AYpuiU7
         8b6dAZPZMG5ggCV7UZI9MBPStx8lOwxR0DxqFyfvocgsBQy18+BFgkiSxtRpL4KUFzOM
         UnZoy5BRkMnhnH5ejxOYYoUIK1COU05dLo0PqODWfSyByRIY7crPD5mm0SSR7OTFb536
         Vzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9mmDYx8WrU8rvHetKafuDvQNZNEWur0WVQdCgfEZspw=;
        b=YAwCdU41qNSS14LxDKYhMp9OHdRjbLjz+iEOmuQYWmyNkgI0c0BqVLxslf0CLhluTM
         FuVHV0LOpGgRUmnGMa+5xPRiSAtdepkIHfngGM8R0hKvskjb9TEhtkcVPy7JmRIySx5r
         Fqz1Wq/BuRtrjeBesIQHBMoaS6XrRKni829dhGlBOwZxi4I6nlaMy2He3+ljHnEWdnAr
         9FOirRGl2ZsfVOOx5fIy9XfNs4mm/03GQA60fgwvldFMclNBsxARTmpqCBJF/Sz8T5gM
         tDq8j3ps9la1LX6amJSBn1x9fLQm6keuNZkXuk3anqa1Oaq55Cy0Si3jYl5hjd2D4hwo
         1WVA==
X-Gm-Message-State: AOAM532bHMib3VUDjpadu/QHG/oUrqLtOTQlla77LOXzi4nsHxQa5Qmx
        78az5ZQ//Qv0DmLk8FbSrZY=
X-Google-Smtp-Source: ABdhPJxZp/BKi4pCSubL4sPpiZCHt5AmUer/L4tlgYku0XHZVMEBaXZZz/rd/r7R8Ru4Z+PNDK1nug==
X-Received: by 2002:ac8:7388:: with SMTP id t8mr1294476qtp.187.1599588185280;
        Tue, 08 Sep 2020 11:03:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:87d8])
        by smtp.gmail.com with ESMTPSA id v16sm7627009qkg.37.2020.09.08.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:03:04 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:03:02 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkcg: add plugging support for punt bio
Message-ID: <20200908180302.GE4295@mtj.thefacebook.com>
References: <1596722082-31817-1-git-send-email-xianting_tian@126.com>
 <8f84e1fe-9fa5-b7e7-1f2f-b0c4a40614e2@kernel.dk>
 <42b939c2.e08.173c6f79af9.Coremail.xianting_tian@126.com>
 <1ded6246.2c67.17458ce4300.Coremail.xianting_tian@126.com>
 <65e1e040da644ed9a05edd166d06b5e3@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e1e040da644ed9a05edd166d06b5e3@h3c.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 05, 2020 at 11:25:03AM +0000, Tianxianting wrote:
> Hi jens,tj
> Could you share a couple of  minutes to comment it?
> I really appreciate it

The result looks fine to me but can you please summarize that in the commit
message of the patch?

Thanks.

-- 
tejun
