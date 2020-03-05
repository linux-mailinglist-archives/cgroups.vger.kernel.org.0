Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42117A905
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 16:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCEPjv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 10:39:51 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:41807 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgCEPjv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 10:39:51 -0500
Received: by mail-qv1-f42.google.com with SMTP id s15so2596152qvn.8
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PHq9PaeVGtyudk0wOTWZY80KOkaKDj/XvNUNHTcU/hU=;
        b=st265gUVi6yGmxIN+nyLlX9bI0TZYas/Sz1TACzRXEO0WsuHyBBHN+VJCFf49CjWOK
         O/Kqo75c9VQGL/OBHP+jKGyGvguT1v4JDGpgwSqbi8BlLcePzstMqZu3B7ljA0i0m1zn
         Pn9/sKYplZJfqEPkySASJ2XYQCboTZZSQIgqYReLFiukIgvov+qJnOdVPb52daw8SipC
         ZKlqq0Xs0QXTo/Q79Lijg7YZCvpe9D/p1yf1i+oTH0TeNV3ju4wZSgYs15DjwMm4QIdB
         GJwSOhKCZ08ksO0b2LR2UOP0tHQN+hmJwB0KKr9R8E1XQykMTfuObZfEeVhcEQ9KRscb
         zAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PHq9PaeVGtyudk0wOTWZY80KOkaKDj/XvNUNHTcU/hU=;
        b=eK6TfkEsB01V1173IMq227rvBLnHawjf3iXzMp86wnSSHtoXs0/2k69OdP/EueF0+a
         ZU+TuaqzBcTrj8trhZkFdCaPx6HMcqu8xGVWRQ+6atQjBOGEIfx/MgYTBvqYtJMcuFQC
         OQzpFSlyQOHnvndclsYmkYK4WJLb8EF9n4zrQUHQXpgM2IuDnK5gSRoTh/JTT2/yybLA
         AfN4QlMReHCaVJ5r3T50xnrjLKTZX+0iWKH/6L85BxkbDaFr2b5lEXlCpKVwzUGf10c0
         9iqafjq9tlIJurO9LWA518ojbK3/fJKQ1ZWFvgNlZc4uHcNq24AnDaqQtk79X6SovUaN
         KSSQ==
X-Gm-Message-State: ANhLgQ1HaIeYJbSrLc51z6lt9w9usx7rDEWnDoPVL2dNX1QfI9mZF2Mk
        sL/37F8/gHrDC/oL2mcqHIc=
X-Google-Smtp-Source: ADFU+vsusAzsBilBFjI2IBRT4Sfk+DxKTs5DRQsO4Wm7pe1X3aYRLzAkICbGN7BYLfq09B8rXsH7ng==
X-Received: by 2002:ad4:58ea:: with SMTP id di10mr2868486qvb.101.1583422789703;
        Thu, 05 Mar 2020 07:39:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e7c7])
        by smtp.gmail.com with ESMTPSA id u49sm15111060qtj.42.2020.03.05.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:39:49 -0800 (PST)
Date:   Thu, 5 Mar 2020 10:39:48 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
Message-ID: <20200305153948.GB6939@mtj.thefacebook.com>
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
 <20200304163044.GF189690@mtj.thefacebook.com>
 <4d3e00457bba40b25f3ac4fd376ba7306ffc4e68.camel@sipsolutions.net>
 <20200305145554.GA5897@mtj.thefacebook.com>
 <7ce3aa9cf6f7501ce2ce6057a03a40cd5e126efd.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce3aa9cf6f7501ce2ce6057a03a40cd5e126efd.camel@sipsolutions.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Benjamin.

On Thu, Mar 05, 2020 at 04:27:19PM +0100, Benjamin Berg wrote:
> > Changing memory limits dynamically can lead to pretty abrupt system
> > behaviors depending on how big the swing is but memory.low and io/cpu
> > weights should behave fine.
> 
> Right, we'll need some daemon to handle this, so we could even smooth
> out any change over a period of time. But it seems like that will not
> be needed. I don't expect we'll want to change anything beyond
> memory.low and io/cpu weights.

Yeah, you don't need to baby memory.low and io/cpu weights at all.

> > Sounds great. In our experience, what would help quite a lot is using
> > per-application cgroups more (e.g. containing each application as user
> > services) so that one misbehaving command can't overwhelm the session
> > and eventually when oomd has to kick in, it can identify and kill only
> > the culprit application rather than the whole session.
> 
> We are already trying to do this in GNOME. :)

Awesome.

> Right now GNOME is only moving processes into cgroups after launching
> them though (i.e. transient systemd scopes).

Even just that would be plenty helpful.

> But, the goal here is to improve it further and launch all
> applications directly using systemd (i.e. as systemd services). systemd
> itself is going to define some standards to facilitate everything. And
> we'll probably also need to update some XDG standards.
> 
> So, there are some plans already, but many details have not been solved
> yet. But at least KDE and GNOME people are looking into integrating
> well with systemd.

Sounds great. Please let us know if there's anything we can help with.

Thanks.

-- 
tejun
