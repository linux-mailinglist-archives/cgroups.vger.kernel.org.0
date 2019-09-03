Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8279A632A
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 09:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfICHzz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 03:55:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38506 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICHzz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 03:55:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so17622038edo.5
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AmAnl8kfE0vBI96hdeUKYAwDGENm90ZrAc9j932dkWk=;
        b=iQMmbEKgIKuMneIbsrUBAZYlU4Mg+FeMtANYlS6Dl5ifcZg4VGyCjb1JFiQUT7btFd
         nYpM3eu6ZkxFgg+n/Io7Jn5hT5uw31/DUBhLS6ruwdTHq4AT7kihHaG/r2X3RyMstpb3
         adstYR0gjOB+q20iq8zQ+/I9/Ai1x9sYhh6Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AmAnl8kfE0vBI96hdeUKYAwDGENm90ZrAc9j932dkWk=;
        b=C94ZHsRhHy7q72lbEt8x/hUoZ+q8zufsGSuHJdenhogPOZZ/FOiaebwQmdrwImW0ik
         do8z59S7cTwC/CkGQ0oEiEPrmx/f5gqDvyRtwrYqcyyjqfGnc8chLmSI5O5HXkjm60bv
         +JgmnKVB0ZUEqp6OkYzZqC8/JQfETaOUXDIxe5XpdPEKPMry+SXCVcKK6VJ4iFhPf/Ih
         XWOq0f74xH9dajHLvyZfIaG6OSZxcWN7vj6xiLyJsGomMRWtfbCoZqAq5EkeTnEmDwSP
         9gKe4sf3RVQeTZpz/OgJ3bTEMuodR+0PDGZA88B7OikqgFiJfvst+7bHep4mWH0L96G0
         0WVg==
X-Gm-Message-State: APjAAAX/rubBf477013QIsi2ALgxZIURnWYe/4cE0RGHpSTmwMBGP4Uw
        LOivZCwP25L2RGjJ3ZQayEUPhQ==
X-Google-Smtp-Source: APXvYqy9u46WjLxxF2M4g4BWzlWEqsYbrIpLaHO40gsB5L5SjPuxVBEmsEciOorZrj9TrV4x1gUNZA==
X-Received: by 2002:a50:d903:: with SMTP id t3mr6724598edj.117.1567497353465;
        Tue, 03 Sep 2019 00:55:53 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id q10sm2251744ejt.54.2019.09.03.00.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:55:52 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:55:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tejun Heo <tj@kernel.org>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, y2kenny@gmail.com,
        cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com,
        daniel@ffwll.ch
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190903075550.GJ2112@phenom.ffwll.local>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 30, 2019 at 09:28:57PM -0700, Tejun Heo wrote:
> Hello,
> 
> I just glanced through the interface and don't have enough context to
> give any kind of detailed review yet.  I'll try to read up and
> understand more and would greatly appreciate if you can give me some
> pointers to read up on the resources being controlled and how the
> actual use cases would look like.  That said, I have some basic
> concerns.
> 
> * TTM vs. GEM distinction seems to be internal implementation detail
>   rather than anything relating to underlying physical resources.
>   Provided that's the case, I'm afraid these internal constructs being
>   used as primary resource control objects likely isn't the right
>   approach.  Whether a given driver uses one or the other internal
>   abstraction layer shouldn't determine how resources are represented
>   at the userland interface layer.

Yeah there's another RFC series from Brian Welty to abstract this away as
a memory region concept for gpus.

> * While breaking up and applying control to different types of
>   internal objects may seem attractive to folks who work day in and
>   day out with the subsystem, they aren't all that useful to users and
>   the siloed controls are likely to make the whole mechanism a lot
>   less useful.  We had the same problem with cgroup1 memcg - putting
>   control of different uses of memory under separate knobs.  It made
>   the whole thing pretty useless.  e.g. if you constrain all knobs
>   tight enough to control the overall usage, overall utilization
>   suffers, but if you don't, you really don't have control over actual
>   usage.  For memcg, what has to be allocated and controlled is
>   physical memory, no matter how they're used.  It's not like you can
>   go buy more "socket" memory.  At least from the looks of it, I'm
>   afraid gpu controller is repeating the same mistakes.

We do have quite a pile of different memories and ranges, so I don't
thinkt we're doing the same mistake here. But it is maybe a bit too
complicated, and exposes stuff that most users really don't care about.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
