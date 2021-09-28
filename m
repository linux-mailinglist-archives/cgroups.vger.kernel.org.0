Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5713C41A973
	for <lists+cgroups@lfdr.de>; Tue, 28 Sep 2021 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbhI1HRf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Sep 2021 03:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbhI1HRf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Sep 2021 03:17:35 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB5AC061575
        for <cgroups@vger.kernel.org>; Tue, 28 Sep 2021 00:15:56 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id o124so21012348vsc.6
        for <cgroups@vger.kernel.org>; Tue, 28 Sep 2021 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fp6qne4sDVozVPRfEtecOGCR659K+zxLKEYiNTurSnI=;
        b=ZVyBiA9LDpqPSNtwJqMcXCGFJQQbh/QPpV70fpQWEehizxAhMa+lDnEld8hzrIHUiW
         XSck4i/I03Y8CgPDwYTB5CSXWgRcTUx5a8+w0IRu3lPfNGxbMRNDjAqwc6EIf3ugN2UY
         osJfTXRNoz7sUNbOxvtP52AR2Udm+NNDFh0Hw6JQvl2oxrRzJkJaduj7l0ZUWDIURdvr
         MISHr/lPjdQoJQuJzEmSt36SVb3R84Wf5+RnO4anw9UNwd6/5Zw+5GdNsEy5hyzXpQpE
         Iq9bbdAixvLBIVyUBIDLUvTS/IUaTjp22g7zFMWMuupEb0Z13zmBBeoexRr175WML3fW
         3QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fp6qne4sDVozVPRfEtecOGCR659K+zxLKEYiNTurSnI=;
        b=01ATWeprrqjszcdTH0KRCAaW1TX3uEAxgnznpAerVRemHXqtI7vghaCQH4EzuGOC7T
         9dQ+i9QAXw/0S9m2En/x7/RRFznhIfVo94H+YuiXkCmsgNyYN1d3wI+EdodddSxcFDgl
         OcWneH5dy1HAztTjK8swzHG1tSuVsirrXzrgpQF6v56QcXSKo7ArwfbwGr7vLlKDSiIs
         lmC4enMLCsM28RpO4D+ZjIrJhWTIKOb+v5DVy++MjoKbm+ntH4ZKV6SlKZkWLRH+ynlD
         V4w/yfMlPt+1+xc3s0PndwTvd/fRljgYE1iZ96W2ABq+yCkL4U2kwdP9LV4E5bflRE4d
         Mr4Q==
X-Gm-Message-State: AOAM533lFmuasOeSlfeYQFv3ZriZOA75AlFNVbe3SzfUfhqzjXVaq6ZA
        m2rYQG6kjcmt6kWMb8tq58F9DfNM1ACjXkafCRE=
X-Google-Smtp-Source: ABdhPJwsJO48P6PJG+xUjw4p6OCbJUvqtXYzIhA+ZyYdtla4/O+o1MfL05vK6QDt3BizGgKMT369eY5WZOWzYtYDxTA=
X-Received: by 2002:a67:f588:: with SMTP id i8mr3701186vso.40.1632813355654;
 Tue, 28 Sep 2021 00:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHKqYaa7H=M4E-=ObO0ecj+NE2KwZN5d7QSz4_b6tXz2vOo+VA@mail.gmail.com>
 <CAHbLzkpBCQp7UGK_WPJ-akdQ7HqkOEMtE6+9qX5ciu3DU-ZVrg@mail.gmail.com>
In-Reply-To: <CAHbLzkpBCQp7UGK_WPJ-akdQ7HqkOEMtE6+9qX5ciu3DU-ZVrg@mail.gmail.com>
From:   =?UTF-8?B?5Y+w6L+Q5pa5?= <yunfangtai09@gmail.com>
Date:   Tue, 28 Sep 2021 15:15:44 +0800
Message-ID: <CAHKqYaZAnz4wiHksKSZMLNEbk9eUUQ1z8iQCLwFgNW40ejByYQ@mail.gmail.com>
Subject: Re: [BUG] The usage of memory cgroup is not consistent with processes
 when using THP
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yang Shi <shy828301@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:28=E5=86=99=E9=81=93=EF=BC=9A
> IMHO I don't think this is a bug. The disparity reflects the
> difference in how the page life cycle is viewed between process and
> cgroup. The usage of process comes from the rss_counter of mm. It
> tracks the per-process mapped memory usage. So it is updated once the
> page is zapped.
>
> But from the point of cgroup, the page is charged when it is allocated
> and uncharged when it is freed. The page may be zapped by one process,
> but there might be other users pin the page to prevent it from being
> freed. The pin may be very transient or may be indefinite. THP is one
> of the pins. It is gone when the THP is split, but the split may
> happen a long time after the page is zapped due to deferred split.
Thank you for reply. I agree that it reflects the difference between
process and cgroup. The memory usage of cgroup is usually used to
indicate the memory usage of the container. It can be used to avoid
the OOM and etc. The disparity will cause that the memory usage of
containers with the same processes are randomly different (we found
more than 30GB different). It is hard to manage them. Of course,
disable THP is a way to solve it. Can it have another way to solve it
?
