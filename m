Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E8199A65
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgCaPyN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 11:54:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44187 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgCaPyM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 11:54:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so23453826qkc.11;
        Tue, 31 Mar 2020 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SHD4oM9r2sY9bG2/tzxFgd57vQnlmusmcQcj5Ymeb3s=;
        b=Z4CMhZHYQT1X347W8+1lC5u9LQ5mHIJZphRCvvEblXanKGSYoIkW7bTLK+NbufhxbM
         2qTH+w3XzPzvREJaLy4ve4EYsiykme0xfAhW2/8gEYRErstb+RePZcICGsRbuvJimOOl
         833WeRueB3PLEY+SgL7+vhNTHVKz6fJEzzYfuNjKf8gJgFv7KfkVyAIKDO0vaZ3eWbgC
         6pOvT/qG4HwaDX0vLCp55yLR4xjOYPj0tIiDh1RWy5JPcHOVrwCOzEkwDijahfSdP77i
         e1R2YOIK1+aHNMGlYER963UFU4JKSxL+NRgZb/BQ1j4MV3pb4QF30GRBpSmzfinzgv+k
         o7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SHD4oM9r2sY9bG2/tzxFgd57vQnlmusmcQcj5Ymeb3s=;
        b=Vbsiw9R5c9ehxwFd2+wWJf5vx/VuZ9ZCCS7rY41ZccTGOVH/9byLPMO5k6NtgEDhmO
         OqorX9r8JlRa2ILCR8hwZeRF60DrHrHOKgSGrrb6ckg2BkxyfQR1iYnnEibC/LpxWv06
         8SOEPfuu+2VwVdrOE5AsEwxAeUiZSQ0K8apTqNDWHUbccJguqFrGuuMDCUhCCgo4Vr+F
         KIUsNENRzclQETs73NoF7SmmVCw1+wUPeoh6/YQImaljVzsfxfCMC4wa7Ll1G93mWzxj
         xoVHDR06K4Blrq0PeYA8Kf3NRjIcE4sNQsf1colJyvlKMbYV11kWfMN+iON58ZUrF/vu
         ku6Q==
X-Gm-Message-State: ANhLgQ0N2GaY6yZaot7Bb7sdfOyYrvIplttUUjB31QpUuDrx8UGeXOPU
        UVsu0WAbgaAAEDVKm24u2YY=
X-Google-Smtp-Source: ADFU+vtmA2Uuio8ivyXkn/LaBIXYX66GosZ34RQ9ZJ5dN73nV7YmEXNKh1VGhwy+FaVbRZmY54Zqjw==
X-Received: by 2002:a37:5d5:: with SMTP id 204mr5656736qkf.59.1585670051486;
        Tue, 31 Mar 2020 08:54:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b946])
        by smtp.gmail.com with ESMTPSA id x124sm12882214qkc.70.2020.03.31.08.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:54:10 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:54:09 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Weiping Zhang <zwp10758@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Nadolski, Edmund" <edmund.nadolski@intel.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and
 nvme
Message-ID: <20200331155409.GU162390@mtj.duckdns.org>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
 <20200331143635.GS162390@mtj.duckdns.org>
 <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
 <20200331155139.GT162390@mtj.duckdns.org>
 <20200331155257.GA22994@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331155257.GA22994@lst.de>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 31, 2020 at 05:52:57PM +0200, Christoph Hellwig wrote:
> On Tue, Mar 31, 2020 at 11:51:39AM -0400, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Mar 31, 2020 at 11:47:41PM +0800, Weiping Zhang wrote:
> > > Do you means drop the "io.wrr" or "blkio.wrr" in cgroup, and use a
> > > dedicated interface
> > > like /dev/xxx or /proc/xxx?
> > 
> > Yes, something along that line. Given that it's nvme specific, it'd be best if
> > the interface reflects that too - e.g. through a file under
> > /sys/block/nvme*/device/. Jens, Christoph, what do you guys think?
> 
> I'm pretty sure I voiced my opinion before - I think the NVMe WRR
> queueing concept is completely broken and I do not thing we should
> support it at all.

Ah, okay, I completely forgot about that. I don't have a strong opinion either
way.

Thanks.

-- 
tejun
