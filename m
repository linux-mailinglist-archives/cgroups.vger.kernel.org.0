Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9658D1B
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF0VdX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 17:33:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39108 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0VdW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 17:33:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so8496978edv.6
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2019 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ymOdyMM4kE64/AUQiKyV50r6ZF407r2qw9+vaz2LbUI=;
        b=MW1qpb3KrqbU/Ri52N56RHJJu7qB/KHN0qgpeEJFE+8Ms9Ugd0095JF4DfwKy7Egk9
         HiMg+Jc+1knkFL32tTiY098a490CCZrIQzEkunpROdZ5dxGhMm3TZgBXeLYDsR+gf+6f
         QRMptRQYM6W86dRG6gll7PSlfiGFvycyPyDHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ymOdyMM4kE64/AUQiKyV50r6ZF407r2qw9+vaz2LbUI=;
        b=BxQFKKR/R1l4el43Mc6juatq4f7y9m6QfvNRxn6TdgjN5HF8VUf3cxcfXDisU5ZPR8
         P3ctjWIc0PMpQb6lSTmiIqlHxVs0K+Vyzf4slP3BuBGo1MBYrnH2IWI6pPv+bK4jObzH
         +2WnEgRxjWyFadey7TXxraVndSaa75Ky5FKfguNh20gUE6nRW0i/UvdJq/kUeFmsejq1
         QdUMtuy2GTjruhgT4tZ110Hq3YbtkM0ledIxxqvi5Twx9jfXC/VHC9XbvpnB1WlOioiG
         Cel3H9bNcGp0wq47fGMLZ/exbdRKdqKIqFedeTuUqXB8V5wi8iMq/L1zHlHPeJR7j+Wq
         sq6A==
X-Gm-Message-State: APjAAAXoEOcCkxo38qeWlSqH8NbevfBlBdYervwC06+2fdSnyfrW2ORa
        xDhRRzVGATJ0Fv1Wmz0h6MLWDg==
X-Google-Smtp-Source: APXvYqxjRbFKIe6IvjmJOpPred6Rdtl4vcg0lEYGA3qs82CKrGWrX1IF77bjtg7XJeyS5vyoT9pSfg==
X-Received: by 2002:a17:906:6a89:: with SMTP id p9mr5325560ejr.44.1561671201380;
        Thu, 27 Jun 2019 14:33:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y18sm40743ejh.84.2019.06.27.14.33.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 14:33:20 -0700 (PDT)
Date:   Thu, 27 Jun 2019 23:33:17 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Brian Welty <brian.welty@intel.com>, kraxel@redhat.com,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 07/11] drm, cgroup: Add TTM buffer allocation stats
Message-ID: <20190627213317.GP12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-8-Kenny.Ho@amd.com>
 <20190626161254.GS12905@phenom.ffwll.local>
 <CAOWid-f3kKnM=4oC5Bba5WW5WNV2MH5PvVamrhO6LBr5ydPJQg@mail.gmail.com>
 <20190627060113.GC12905@phenom.ffwll.local>
 <CAOWid-e=M4Rf30s8ZoK5n2fOYNHhvpun0H=7URsKmsGc3Z0FDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-e=M4Rf30s8ZoK5n2fOYNHhvpun0H=7URsKmsGc3Z0FDQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 27, 2019 at 04:17:09PM -0400, Kenny Ho wrote:
> On Thu, Jun 27, 2019 at 2:01 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > btw reminds me: I guess it would be good to have a per-type .total
> > read-only exposed, so that userspace has an idea of how much there is?
> > ttm is trying to be agnostic to the allocator that's used to manage a
> > memory type/resource, so doesn't even know that. But I think something we
> > need to expose to admins, otherwise they can't meaningfully set limits.
> 
> I don't think I understand this bit, do you mean total across multiple
> GPU of the same mem type?  Or do you mean the total available per GPU
> (or something else?)

Total for a given type on a given cpu. E.g. maybe you want to give 50% of
your vram to one cgroup, and the other 50% to the other cgroup. For that
you need to know how much vram you have. And expecting people to lspci and
then look at wikipedia for how much vram that chip should have (or
something like that) isn't great. Hence 0.vram.total, 0.tt.total, and so
on (also for all the other gpu minors ofc).  For system memory we probably
don't want to provide a total, since that's already a value that's easy to
obtain from various sources.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
