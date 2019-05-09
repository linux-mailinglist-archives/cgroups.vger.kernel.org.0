Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C318E7E
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 18:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfEIQwg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 12:52:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45967 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEIQwg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 12:52:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id t1so3248481qtc.12;
        Thu, 09 May 2019 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUsBtZeNw5FNZWL8p+EHmLQcD3RYdpay6K7eQaM/McY=;
        b=lZ76QuoWP/RlQ75YXkOJcraYtkNTORpFzzVYzxh33URZ1VMjG3Xx5DjtZ3CHin9xa5
         fS/xGH7+lJxkoHr7QwVmyDAjbeF7nvOmxv9beDILF+sB+8CiqCfnpouLazaG1HGm4wWr
         sSEbhOG5/jozTrc/fsmtxtN959XvvWOXy5liSIq+k6J+n2dlsbSH6ap+adywXTDR7kLx
         KiqF0AAJVljqXt6esw6EBUoQy090O3TR79BAiDBzt0e3J3KThFw2L3AVAsylb2+p2P5b
         a2N9dHCQk3vpX1jSLasmI3wCY61bPxdTWmHGDEdgCCrPI+I3gdezXTWfZ9jvSdaQw7fz
         mByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUsBtZeNw5FNZWL8p+EHmLQcD3RYdpay6K7eQaM/McY=;
        b=X+qgnQND/SkWk3uehmAV8cvcDM4jrbVJoc0JzvMMKQHC/g4xRFQnDKGNsVrtMAjvuv
         2dGhA1FzWeOuOokfzCW7ElZWpk21B1QuRSjQBJSUpUS79AtDWf/8sKb7kOMbG3QKnIFV
         BdsSDfWXgjPQn7WuDGvl9nmeg6PG6v70SfKmcz8okamN4QtaTBd4dSvVkAyKjv77/UvF
         uHvIYOf5Vod8wrE/HZ3yjFmQvL1cr0DjSxt0bKBkc1fSJU3artQ7ch0b14N+BEcVxqKT
         3Mny6agn4cy7hFCljYubkmBZnIu4TiXOX3ZLVKyzWboOuMueALeY5wRMeXMW1OiheA2R
         XqCQ==
X-Gm-Message-State: APjAAAW4aogQpAiE6j+DyXsMAwDAkdLUxCCdHxkSZgvTrZmmQi8mUcA0
        4N6rMIS5jJlV/WwDdA2wf3I=
X-Google-Smtp-Source: APXvYqx1t5kT+XXZFiBv+VqPqn8kVEYcdTa7Y4TE5pWMD/WmWnopKPh7/3rEKvsPEmRwg0IA9htZcQ==
X-Received: by 2002:ac8:19f5:: with SMTP id s50mr4695898qtk.281.1557420754955;
        Thu, 09 May 2019 09:52:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c346])
        by smtp.gmail.com with ESMTPSA id x47sm1527214qth.68.2019.05.09.09.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:52:34 -0700 (PDT)
Date:   Thu, 9 May 2019 09:52:32 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Welty, Brian" <brian.welty@intel.com>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>, kenny.ho@amd.com
Subject: Re: [RFC PATCH 0/5] cgroup support for GPU devices
Message-ID: <20190509165232.GW374014@devbig004.ftw2.facebook.com>
References: <20190501140438.9506-1-brian.welty@intel.com>
 <20190506152643.GL374014@devbig004.ftw2.facebook.com>
 <cf58b047-d678-ad89-c9b6-96fc6b01c1d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf58b047-d678-ad89-c9b6-96fc6b01c1d7@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, May 07, 2019 at 12:50:50PM -0700, Welty, Brian wrote:
> There might still be merit in having a 'device mem' cgroup controller.
> The resource model at least is then no longer mixed up with host memory.
> RDMA community seemed to have some interest in a common controller at
> least for device memory aspects.
> Thoughts on this?   I believe could still reuse the 'struct mem_cgroup' data
> structure.  There should be some opportunity to reuse charging APIs and
> have some nice integration with HMM for charging to device memory, depending
> on backing store.

Library-ish sharing is fine but in terms of interface, I think it'd be
better to keep them separate at least for now.  Down the line maybe
these resources will interact with each other in a more integrated way
but I don't think it's a good idea to try to design and implement
resource models for something like that preemptively.

Thanks.

-- 
tejun
