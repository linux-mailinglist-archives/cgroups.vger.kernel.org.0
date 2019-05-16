Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE45120A85
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfEPO6a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 10:58:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43828 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfEPO63 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 10:58:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so3673656oth.10
        for <cgroups@vger.kernel.org>; Thu, 16 May 2019 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAXmI7ViLmDBzBy7WEsJO+IrrN0Omh7qQ2SpFzX3/qs=;
        b=piJeisUUwhQRZ4+x66kX29/b7KYSDS/xiEOhSVsuGfA88FR0gy17SWN8ZvKyzH/5OM
         W5NrghFtsMJjX+KJK8MbT7k/sKBwXA1Q86xf/hmuSistn2gp9iYvM+eFcv5Wv38A0V4o
         fQFOLhF6Z3J42Qw1knKNFsvMfWVeVbKVnXljL2RKu5QBVB8LjQNjNKJrCT5d7DfIcdqN
         Kpxv4r0XcOQX88YqCR5YckcRZmAX5wFWS0gZfybmpZBBK5xdYSUZXfruKByEolBgHy3w
         yT2tNvJNktVvuL3/j4/zLXDwBe+uXf0jYtuhE/5lC2qu7zhaDw33EN1uO6wVFNFDUUQc
         lUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAXmI7ViLmDBzBy7WEsJO+IrrN0Omh7qQ2SpFzX3/qs=;
        b=F2XfaYBjEf+rkiHFsb7h7JyE6DX/hiqypBj9iDrMBtLqe/4dqMCXWYHUUQfDusy9Wi
         0Xd1GIJ9FOxarkDnNzRivjFom9TwsvkrAZYFhLFLLzwmPwh/teeUEeO81KsPhD1/HSSq
         kCm9DYVYSQYKf8qKpmcX8/ttX12tTwv/+Fy+0m/UCh2JIcI7TQPkqtILxqdnyIxkAax2
         vP6jm++HHCMrRX7jwk+pu5dMCSFfH0yExIBP/l1DTOqIVhxJIkruxWnfHW4mBTSvJDNC
         B2ZvTN6kA/7hhITM94gUq4hNeYn6ReSCbgRaZJ5Nxgvra39/p26ErdXkhO6prK4/nOcf
         zEwA==
X-Gm-Message-State: APjAAAXchK6K6e51f6XlmFP6+9N5JzRFyBErHsYvtlVo6gmAWuQBwrfW
        DdQncjW21ojWVQ31DSGNqwRaZ+zuOyqq0zeeqjo=
X-Google-Smtp-Source: APXvYqznfGfE9F/rQ0XB6eKk1l3lCo+w+8PyryMdB3vQAgGRL1rSuYWgMuTu3eRCvNetuh1xbsXNohyC/nD7XFRpiLg=
X-Received: by 2002:a9d:754c:: with SMTP id b12mr22534otl.237.1558018709075;
 Thu, 16 May 2019 07:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com> <d81e8f55-9602-818e-0f9c-1d9d150133b1@intel.com>
 <CAOWid-ftUrVVWPu9KuS8xpWKNQT6_FtxB8gEyEAn9nLD6qxb5Q@mail.gmail.com> <20190516141015.GC374014@devbig004.ftw2.facebook.com>
In-Reply-To: <20190516141015.GC374014@devbig004.ftw2.facebook.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 16 May 2019 10:58:17 -0400
Message-ID: <CAOWid-fU7ScF7-+Ox-y2RHLeXVZmDOno=nLDf6HtToAPFwNNrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation limit
To:     Tejun Heo <tj@kernel.org>
Cc:     "Welty, Brian" <brian.welty@intel.com>,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        sunnanyong@huawei.com, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 10:10 AM Tejun Heo <tj@kernel.org> wrote:
> I haven't gone through the patchset yet but some quick comments.
>
> On Wed, May 15, 2019 at 10:29:21PM -0400, Kenny Ho wrote:
> > Given this controller is specific to the drm kernel subsystem which
> > uses minor to identify drm device, I don't see a need to complicate
> > the interfaces more by having major and a key.  As you can see in the
> > examples below, the drm device minor corresponds to the line number.
> > I am not sure how strict cgroup upstream is about the convention but I
>
> We're pretty strict.
>
> > am hoping there are flexibility here to allow for what I have
> > implemented.  There are a couple of other things I have done that is
>
> So, please follow the interface conventions.  We can definitely add
> new ones but that would need functional reasons.
>
> > not described in the convention: 1) inclusion of read-only *.help file
> > at the root cgroup, 2) use read-only (which I can potentially make rw)
> > *.default file instead of having a default entries (since the default
> > can be different for different devices) inside the control files (this
> > way, the resetting of cgroup values for all the drm devices, can be
> > done by a simple 'cp'.)
>
> Again, please follow the existing conventions.  There's a lot more
> harm than good in every controller being creative in their own way.
> It's trivial to build convenience features in userspace.  Please do it
> there.
I can certainly remove the ro *.help file and leave the documentation
to Documentation/, but for the *.default I do have a functional reason
to it.  As far as I can tell from the convention, the default is per
cgroup and there is no way to describe per device default.  Although,
perhaps we are talking about two different kinds of defaults.  Anyway,
I can leave the discussion to a more detailed review.

Regards,
Kenny
