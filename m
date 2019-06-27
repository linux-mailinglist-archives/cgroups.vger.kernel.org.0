Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4AF58A1D
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 20:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF0Sm5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 14:42:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36265 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Sm5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 14:42:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so6636336wmm.1
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2019 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zJpPVll8AeA53RzbA9bthek/cTS84PNHogBiBCIRPms=;
        b=jiPD44QWifbSTAoFhvoO7EEvQqyxTHlknQO97q8/HR9uCLC7fEifhfdXVermJbY4A5
         JzT7urvC+mZbb5Fe5Z7gBuOMttYKl/E6PaN+nzpy6zJSFdpd0tHN6Qno/QbiWxh+/8mh
         axSsAPMjtP23H8W9st/uvDglGavW99bf0ZipXALDTEZXazUvs++gJo2F6ZEhi/KmiQNi
         A/ZQ6VMyXl9mYeaeL/HXJlrVSd0hDeuV+un/lT+K6E3H18WdLj0Vau/jU5DY+KE7L+MM
         k4FY7izYcpcduX7SHzmQAx07GG1RFFxm2uMDCCvI1ctYa4g6EaPH66zylH/J3Cx9nM7Y
         nwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJpPVll8AeA53RzbA9bthek/cTS84PNHogBiBCIRPms=;
        b=kwV4bFtgTqeD6577On47yy/UGgSXq5LE3bPbGamvowJO9A2XILfUjLpUo7bAXmQZS6
         z/hTud43KetHlCnB0Qwd8RBmIbH0ymsF8B/u2b0VgTsUc+0HAjKIT8hV+7I5Mvxrwj+n
         0z2/o3T36AhakDGUWY+VjH35yOS7isOmTp4pZ50VTtjh/oes2uiG+WXOAJAhUbUGvjIF
         0c7UpkYWDwkB1MZw/SNaFLArOwHvPkqEPPgkx4qebnb0eV7oqPon5bJV5vWCL1iGikxl
         8HILbtLICptrPN/TSpcuI2ksyUGlvW+GaKb9na/eH3x6I7MZgZzlvsJuC5uQVr3Dbtnw
         MjsA==
X-Gm-Message-State: APjAAAVTCxg1xF5FJhJocLcPORg2H1rP2Fh5a7exKs7bJLPiBMQZtS1y
        9PRGSk9UEEd5G4KcbyRhqT+ezBwxoCviP+nFLr0=
X-Google-Smtp-Source: APXvYqxgdheUrE2X+cNTl4Kxcd54xMoZiWuD3Gq3vM05teW0J5JiLNdb7Gu0G439xUVtbFCWSfKw8fSucM2Q7f3z/eQ=
X-Received: by 2002:a7b:c356:: with SMTP id l22mr4183486wmj.97.1561660974801;
 Thu, 27 Jun 2019 11:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local> <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
 <20190626214113.GA12905@phenom.ffwll.local> <CAOWid-egYGijS0a6uuG4mPUmOWaPwF-EKokR=LFNJ=5M+akVZw@mail.gmail.com>
 <20190627054320.GB12905@phenom.ffwll.local>
In-Reply-To: <20190627054320.GB12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 27 Jun 2019 14:42:43 -0400
Message-ID: <CAOWid-cT4TQ7HGzcSWjmLGjAW_D1hRrkNguEiV8N+baNiKQm_A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer allocation limit
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 27, 2019 at 1:43 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jun 26, 2019 at 06:41:32PM -0400, Kenny Ho wrote:
> > So without the sharing restriction and some kind of ownership
> > structure, we will have to migrate/change the owner of the buffer when
> > the cgroup that created the buffer die before the receiving cgroup(s)
> > and I am not sure how to do that properly at the moment.  1) Should
> > each cgroup keep track of all the buffers that belongs to it and
> > migrate?  (Is that efficient?)  2) which cgroup should be the new
> > owner (and therefore have the limit applied?)  Having the creator
> > being the owner is kind of natural, but let say the buffer is shared
> > with 5 other cgroups, which of these 5 cgroups should be the new owner
> > of the buffer?
>
> Different answers:
>
> - Do we care if we leak bos like this in a cgroup, if the cgroup
>   disappears before all the bo are cleaned up?
>
> - Just charge the bo to each cgroup it's in? Will be quite a bit more
>   tracking needed to get that done ...
That seems to be the approach memcg takes, but as shown by the lwn
link you sent me from the last rfc (talk from Roman Gushchin), that
approach is not problem free either.  And wouldn't this approach
disconnect resource management from the underlying resource one would
like to control?  For example, if you have 5 MB of memory, you can
have 5 users using 1 MB each.  But in the charge-everybody approach, a
1 MB usage shared 4 times will make it looks like 5MB is used.  So the
resource being control is no longer 'real' since the amount of
resource you have is now dynamic and depends on the amount of sharing
one does.

> - Also, there's the legacy way of sharing a bo, with the FLINK and
>   GEM_OPEN ioctls. We need to plug these holes too.
>
> Just feels like your current solution is technically well-justified, but
> it completely defeats the point of cgroups/containers and buffer sharing
> ...
Um... I am going to get a bit philosophical here and suggest that the
idea of sharing (especially uncontrolled sharing) is inherently at odd
with containment.  It's like, if everybody is special, no one is
special.  Perhaps an alternative is to make this configurable so that
people can allow sharing knowing the caveat?  And just to be clear,
the current solution allows for sharing, even between cgroup.

Regards,
Kenny
