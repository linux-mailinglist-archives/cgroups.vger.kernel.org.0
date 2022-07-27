Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7709458273B
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiG0NAe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 09:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiG0NAc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 09:00:32 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A13B4B5
        for <cgroups@vger.kernel.org>; Wed, 27 Jul 2022 06:00:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id cx10so684065qvb.0
        for <cgroups@vger.kernel.org>; Wed, 27 Jul 2022 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6b1aqsIK88pylFiOISBY0ELZL9Xn38SDDWKXVWVdB4=;
        b=mxeEHVKroQaEoNkoAbosEAI+dwFaB8qB8NsFaQPj5VYhC75/7PYl6GD/R0zO3TyA1o
         nBoj0AqdsPWFpokMFX7xH1L99L/Wt5B3Vhap0k0fS0Wvpxa4tOtPicKtinbNQMNuutQ/
         YMVBISTb6VDgAqg17inYCaUofGhW7ywH/m9nNmo/oAm55BIbDT+vkFKe9oij5crJdKPZ
         yc3QzeBkdujnDYXXN2sg9rxjjeXVghNgNJffb03vGdBSiCc8kfoJzJNXPTdAQPi0o/oD
         LJgEWF4gM6XX9sS8R+p8R9tweLfFEPPDS3fyv1LmunM9vr+l6K6rj3qoJCRwHUS/nD0V
         wf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6b1aqsIK88pylFiOISBY0ELZL9Xn38SDDWKXVWVdB4=;
        b=IThHM07BgHYFsD1RqgDjaitosoK/hdMZhBmaGelx1ObYInmx7oQV3AF+XYErmZv906
         8P8sguSYCR4EAUujE5oeLkeekzQzBJoK26yKv+SODlbMk0ZeLe6cyW1iWkAWypVt6T1W
         r5ntgiCxL8/5cQf1ewBtBLCvDKK1PgtAzf+BaP9p+qszxm6r3dXJwbwUHhNBG5WvUVfs
         eXPu3OjQ06HVoxCgEHoSZhxSFtUP+O9lnYo+br57pg+dacQ5deVy6R3QqAXyKQ+E6hk6
         /xfs+w9zCddlAS6FML25zBOCTuobUmAeay5WHy6uDxACD9CjOWEaFLXNTMwpVvoMMOlR
         liug==
X-Gm-Message-State: AJIora9uHpedx4YTQgsVlZGKv6AcwMhkUvJco3LHHikWiBjwg5/DXdkC
        p/WDFlx0TiE4W4AH8XDXKuDUug==
X-Google-Smtp-Source: AGRyM1tQlxdrNIeWa4eutKhbk2YT1/mYsEXphAU0xZQV+RpGi7NGdgSIVDLz7QE85q7UyjWbQXje1w==
X-Received: by 2002:a05:6214:f0b:b0:474:11dd:177d with SMTP id gw11-20020a0562140f0b00b0047411dd177dmr18192068qvb.111.1658926829378;
        Wed, 27 Jul 2022 06:00:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id l25-20020a37f919000000b006b61b2cb1d2sm1985419qkj.46.2022.07.27.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 06:00:28 -0700 (PDT)
Date:   Wed, 27 Jul 2022 09:00:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 9/9] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Message-ID: <YuE26+jMjnE4GZZ2@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-10-zhouchengming@bytedance.com>
 <Yt7gOhbqYzIKyhfv@cmpxchg.org>
 <5f91e194-439a-12c0-4987-5dea0e68a60a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f91e194-439a-12c0-4987-5dea0e68a60a@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 27, 2022 at 07:28:37PM +0800, Chengming Zhou wrote:
> On 2022/7/26 02:26, Johannes Weiner wrote:
> > I think we can remove the NR_CPU task count, which frees up one
> > u32. Something like the below diff should work (untested!)
> 
> Hi, I tested ok, would you mind if I put this patch in this series?
> 
> Subject: [PATCH] sched/psi: remove NR_ONCPU task accounting
> 
> We put all fields updated by the scheduler in the first cacheline of
> struct psi_group_cpu for performance.
> 
> Since we want add another PSI_IRQ_FULL to track IRQ/SOFTIRQ pressure,
> we need to reclaim space first. This patch remove NR_ONCPU task accounting
> in struct psi_group_cpu, use TSK_ONCPU in state_mask to track instead.

Thanks for testing it, that sounds good.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>

Since you're handling the patch, you need to add your own
Signed-off-by: as well. And keep From: Johannes (git commit --author).

Thanks!
