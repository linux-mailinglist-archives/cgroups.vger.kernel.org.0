Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A667D5E80B3
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiIWR34 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 13:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWR3z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 13:29:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD40A5B7BF;
        Fri, 23 Sep 2022 10:29:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b5so852582pgb.6;
        Fri, 23 Sep 2022 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=No+zB8N8/I6uv9gE3yfw5UXtcRDIM1VBhtQdkeHbVVQ=;
        b=IQsFLvu+KTdRASYHh2un+r7HH3He23RjO0OQhdDgZDlzm1pSH8ryafMC7XEzlvf+mY
         hZ++BIKCaXXGlw9bP/2M1pT8z4HIzkXddki+Xmcr0WWZl9sJfHFLKMjOniqI+pn31F3l
         G3llMF+POQvXkxCcSOnQOL/5MQefl1o9ZIQO6+Nh6HteoQKPjI/Vh3I7vrvy7ImnIXK+
         VCnOdqjngEXm4DYGFXZTp02xZ1lIg2T+XYRMuIOrcNm1imtM+N3FKy28jWxHQi7ZqmNq
         2lUpwouatFNzlk/8Is3d3so9D8USBa5J4/2LdMcJGPnUL1vqeVkHSo6gZOlnBrib+9OE
         f29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=No+zB8N8/I6uv9gE3yfw5UXtcRDIM1VBhtQdkeHbVVQ=;
        b=jDryDdzXVHW+3MDrjNPPi8wlW7b1sheDlgvmBXaKtzIQt0QkC4M7OQUGTe9UEuNL9F
         tx+uQpv1IOiA83kaLZ4F2CtD2yU3cirsJ/c57zhrcsjVMjDSBtjuVosvklb7fwNXxXIJ
         1feOMGpeTDJNHHNi2G6SfWbbcdslNTtghUixbGapzg/1CmlJDf6qcAJj8xojFC9NFduA
         OtBSfLxI8iPVladE41ZFw0lqMCydKEfRS11Q5oNSXFWMMa2aECVn/UEjt+U5N/knDZEX
         y8Wg+PtbVUDoaijT0EABGpYO33bwXxZmD4a9S7+o5xyuHoSYQbrltk6RALUFvzB/jQFW
         t3RQ==
X-Gm-Message-State: ACrzQf0B3v8NEGuE8SAgtg66zhA0ky/T5gpeoGwBKyLeJqWUnZw/ybdS
        Jz2CaQwQ0NRu9vt40PUXY2SFQUzRwK7g2g==
X-Google-Smtp-Source: AMsMyM7du1QFQbWN28iiLlTrXRu0ONnf4K/DvpFjcPM0Bi6fQv1Gu0XBK9K81QQy6740V8VrDlUY1g==
X-Received: by 2002:a62:2503:0:b0:538:426a:af11 with SMTP id l3-20020a622503000000b00538426aaf11mr10212336pfl.22.1663954194097;
        Fri, 23 Sep 2022 10:29:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903410b00b001743be790b4sm6101339pld.215.2022.09.23.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:29:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 07:29:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Marco Patalano <mpatalan@redhat.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH] cgroup: fix cgroup_get_from_id
Message-ID: <Yy3tEKSV+vg6swOd@slm.duckdns.org>
References: <20220923115119.2035603-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923115119.2035603-1-ming.lei@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 23, 2022 at 07:51:19PM +0800, Ming Lei wrote:
> cgroup has to be one kernfs dir, otherwise kernel panic is caused,
> especially cgroup id is provide from userspace.
> 
> Reported-by: Marco Patalano <mpatalan@redhat.com>
> Fixes: 6b658c4863c1 ("scsi: cgroup: Add cgroup_get_from_id()")
> Cc: Muneendra <muneendra.kumar@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Applied to cgroup/for-6.0-fixes with the subject changed to "cgroup:
cgroup_get_from_id() must check the looked-up kn is a directory" and stable
cc'd.

Thanks.

-- 
tejun
