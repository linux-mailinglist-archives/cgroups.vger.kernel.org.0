Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE74B5D066
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2019 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBNVt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Jul 2019 09:21:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32933 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGBNVt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Jul 2019 09:21:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so27317377edq.0
        for <cgroups@vger.kernel.org>; Tue, 02 Jul 2019 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fkANFdIynH0ClOKT8icytDm2bPs8Oi+kCWWSVdcdA8=;
        b=BTU52gar4d2uAXU7lUx5EpJIF3EcAp0CiRv1mW0icR0JHvBgE+FlPJLuARtyRQJRDw
         hkjUc125FywMVMfJBYGA2ntZYZ5rGikIrisudqwjZpZNMueIW2/Hsg68j/8iZ7ZTK5wM
         d6+lMzt+8S3twI2IJAddGxnM6D7yK822me3kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fkANFdIynH0ClOKT8icytDm2bPs8Oi+kCWWSVdcdA8=;
        b=KVj7INY7vpRbGOY1uJyx93YEYrTdF4CunkElFs+u+lC87VgiHjvtcjBZm2vxBmdgUF
         sKoFVwUn7fklQX5TgPYNkbbnfeDagOUIKfYQIRIWcjv4KqN0SeWaNmevnZoL4wHo4V8x
         tcy45kv6E6loEK+QA1E3bDG3Wcq4wdU7LLt40LVu+KMrlKXDv0p+JdgoJUm1M3zhHA8j
         7KqQ9HStbIBCDRdo79NEGfrstDcLjtN7J15l9XrGed4LzMTfj1tI7jZVHmBqRO1EUvjH
         AMWvj7kuNfjt+xWRFpYddZc1kcdogY9jky+rbdN7tjUBVUK4Cff8ymmjWDCJrg+XUSAV
         /cWg==
X-Gm-Message-State: APjAAAVOrJwMwbHOVT9PE/CnKZveRTXyBNdOl3qGOtjB3Ewl7XsCAtGk
        8QwruF0BF2dBpYAE///sbM4cFA==
X-Google-Smtp-Source: APXvYqwowvc8e4ZheEmGpoF6aPCzIdTqQI1K+iW3qBLevgjjlBPWrFh2dxKneIMd8Pj3DvnH+Fqfig==
X-Received: by 2002:a50:9451:: with SMTP id q17mr35506080eda.119.1562073707787;
        Tue, 02 Jul 2019 06:21:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e22sm353050ejj.61.2019.07.02.06.21.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 06:21:46 -0700 (PDT)
Date:   Tue, 2 Jul 2019 15:21:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
        Jerome Glisse <jglisse@redhat.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 00/11] new cgroup controller for gpu/drm subsystem
Message-ID: <20190702132144.GC15868@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <CAKMK7uFq7qCpzXqrD4o8Vw_dOwt=ny_oS7TRZFsANpPdC604vw@mail.gmail.com>
 <CAOWid-e-gxFBoiBii4wZs0HMnHwCvJWOQWpNopdPHi8So53gNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-e-gxFBoiBii4wZs0HMnHwCvJWOQWpNopdPHi8So53gNw@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jun 30, 2019 at 01:10:28AM -0400, Kenny Ho wrote:
> On Thu, Jun 27, 2019 at 3:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > Another question I have: What about HMM? With the device memory zone
> > the core mm will be a lot more involved in managing that, but I also
> > expect that we'll have classic buffer-based management for a long time
> > still. So these need to work together, and I fear slightly that we'll
> > have memcg and drmcg fighting over the same pieces a bit perhaps?
> >
> > Adding Jerome, maybe he has some thoughts on this.
> 
> I just did a bit of digging and this looks like the current behaviour:
> https://www.kernel.org/doc/html/v5.1/vm/hmm.html#memory-cgroup-memcg-and-rss-accounting
> 
> "For now device memory is accounted as any regular page in rss
> counters (either anonymous if device page is used for anonymous, file
> if device page is used for file backed page or shmem if device page is
> used for shared memory). This is a deliberate choice to keep existing
> applications, that might start using device memory without knowing
> about it, running unimpacted.
> 
> A drawback is that the OOM killer might kill an application using a
> lot of device memory and not a lot of regular system memory and thus
> not freeing much system memory. We want to gather more real world
> experience on how applications and system react under memory pressure
> in the presence of device memory before deciding to account device
> memory differently."

Hm ... I also just learned that the device memory stuff, at least the hmm
part, is probably getting removed again, and only the hmm_mirror part of
hmm will be kept. So maybe this doesn't matter to us. But really no idea.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
