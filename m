Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0105ABC7B
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbfIFP3a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 11:29:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33536 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391993AbfIFP3a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 11:29:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so6036901qkb.0
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/OO1E7LJG7tbWcZdjZZ/ZvJB7xoR1AfPJejmKq9KUI=;
        b=qTRFHmFQimhNPTGJfIbGiQhea4mqqdyjlzhlY+Idm+aSLkpc7AYdXxIdUAzy3Q08AT
         cwvhXSv1nrv1OzbBLOw/SvSmOgiW3O6H1osyJVZUBi/B1srB/J35Oyoxi8S2GInDRzo0
         OyLatA0rMLYZVWpvbcQd2Yjgn5HPyOfx+eSBwZULfmVVVMYGYVKcohoUk3WxUNOISt+G
         ht/zbqIFqp7D+yvTK1uNzHop8RpurCw0RVvB93dfpwdx25fXCvsSgaRwMu6RCY7XYmTM
         fBNaIgO7X5xImNsKIFTYEXrg4qd65aKSTEWeXhLCS6NGmCg+chp1ExU97nx7PJVN5V51
         6HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/OO1E7LJG7tbWcZdjZZ/ZvJB7xoR1AfPJejmKq9KUI=;
        b=lwtck9YkIQG7SSy0z3O+eCIq7XrB2MjOZu34VIbsEaz5hQi+QhNsgW431QIQF1xxw0
         6QT+PS8J5vR0r8wQMCqoxaP5THVyQRi/qlvaLD8mJsWH8rSNX4zPceQFFaR0o4gxyUpf
         6qsB9SVhlVI8/HKJ0EC5MSJw5w92ISbNa+GNmBYHzF10bDWZiQL8WwSqgLfvZ4yC3w4D
         6yKsDYqlZ4Xb8zAZ4gCipXq4dp4EEUQrDOWAs6EZtuejLwWu9tVesIXfazawKrrmxXIG
         HbUTFwAMiq4u+7bFUuBNaJOhrYf+Cf7I6mAABAOtmK/mFgYxurdVLqS/TxgJee/Ly/eb
         t63g==
X-Gm-Message-State: APjAAAWYC3Xd0yNA9m6zMQYfD328XBIerfT0gedynOANf38r1jBdqB/p
        cD4feOX1xyhb18V+6K3W5Ds=
X-Google-Smtp-Source: APXvYqzDUt/HLbUz5nMnb5lDEIlxnPoyo5pcHHv7+84TuScHqxwTG6/IxqfiMB4xhsuHP3hUlqM3SQ==
X-Received: by 2002:a37:4c9:: with SMTP id 192mr9732279qke.177.1567783769321;
        Fri, 06 Sep 2019 08:29:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e7cb])
        by smtp.gmail.com with ESMTPSA id j17sm3492093qta.0.2019.09.06.08.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 08:29:27 -0700 (PDT)
Date:   Fri, 6 Sep 2019 08:29:25 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <y2kenny@gmail.com>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
Message-ID: <20190906152925.GN2263813@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local>
 <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
 <20190904085434.GF2112@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904085434.GF2112@phenom.ffwll.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Sep 04, 2019 at 10:54:34AM +0200, Daniel Vetter wrote:
> Anyway, I don't think reusing the drm_minor registration makes sense,
> since we want to be on the drm_device, not on the minor. Which is a bit
> awkward for cgroups, which wants to identify devices using major.minor
> pairs. But I guess drm is the first subsystem where 1 device can be
> exposed through multiple minors ...
> 
> Tejun, any suggestions on this?

I'm not extremely attached to maj:min.  It's nice in that it'd be
consistent with blkcg but it already isn't the nicest of identifiers
for block devices.  If using maj:min is reasonably straight forward
for gpus even if not perfect, I'd prefer going with maj:min.
Otherwise, please feel free to use the ID best for GPUs - hopefully
something which is easy to understand, consistent with IDs used
elsewhere and easy to build tooling around.

Thanks.

-- 
tejun
