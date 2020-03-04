Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC017906F
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgCDMcV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 07:32:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45837 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDMcV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 07:32:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id v2so2152593wrp.12;
        Wed, 04 Mar 2020 04:32:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOoIMe4ipuObrP+M1ytu6BXg4FmUGi1YFKtc9FzmxHk=;
        b=k1jBNafNagIx53DiNwjOOrymH4k7l5lJ9DKD5UabdltRBPsblcBwxncK/G8TINIXpL
         AjmglINw36fmuwY/ePNT3pp/T91HEUGxIZpaDtUs1MKMiF7vK+nP/76bXoHzb4jFl6w5
         XCzGcPqVsNASaUfSiuj41GYuMw6dpmgLHcc0QkpmRZjR0VYw0gm2D5AhsXcnfv4VcI9Y
         RTyNrD9XIXU5TAsDkXpHQYBFTAOPKWZ2LgwIe98ZOtFL+0ObZm2CQCTA91vSaemRoLfi
         fxzF2EL8DAp4dgUOXeFleF//zkGqn1QERDSpAgvZBvtiCkqiucoJR9zFv/6+lWRluEe3
         /1hQ==
X-Gm-Message-State: ANhLgQ1oEJWKdVxEIb6UXc1+rZQoJ6n0zVjq5xDCaxmyCIhMRCM8jAmG
        EiCJO40GlAtAsdlP7sVmx3I=
X-Google-Smtp-Source: ADFU+vu2v6UTlvfB5gN7rglYo5YNbLmHFipxXKL6wWNpjacyXl05jHGXC9Tow/qo/wLCBkMUNsWsHQ==
X-Received: by 2002:a5d:6141:: with SMTP id y1mr3739043wrt.146.1583325138786;
        Wed, 04 Mar 2020 04:32:18 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i204sm4029964wma.44.2020.03.04.04.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 04:32:17 -0800 (PST)
Date:   Wed, 4 Mar 2020 13:32:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memcg: css_tryget_online cleanups
Message-ID: <20200304123217.GK16139@dhcp22.suse.cz>
References: <20200302203109.179417-1-shakeelb@google.com>
 <20200303093251.GD4380@dhcp22.suse.cz>
 <CALvZod7C9nrS4S36AfTY74cx0=58LXNNh_b+mXzXNG1j9_6RZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7C9nrS4S36AfTY74cx0=58LXNNh_b+mXzXNG1j9_6RZg@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 03-03-20 15:49:41, Shakeel Butt wrote:
> On Tue, Mar 3, 2020 at 1:32 AM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > Could you be more specific about the swap in case please?
> >
> 
> With swap accounting enabled, if the memcg of the swapped out page is
> not online then the memcg extracted from the given 'mm' will be
> charged and if 'mm' is NULL then root memcg will be charged. However I
> could not find a code path where the given 'mm' will be NULL for
> swap-in case.

Yes, this is my understanding as well. All the paths are getting mm from
a vma AFAICS. This is a valuable information for the changelog.

-- 
Michal Hocko
SUSE Labs
