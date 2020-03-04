Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18B179665
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 18:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgCDRKy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 12:10:54 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:44971 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDRKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 12:10:53 -0500
Received: by mail-qk1-f169.google.com with SMTP id f198so2336170qke.11
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2020 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uJ4VaOT8ap7MxQeWLu8CCH/zVyGcddyQFtuX8XLS83o=;
        b=Ioqv49nh9KevXjhnxkj76lUa5agqAyWoNdQwNoK3ELZT0L51uwZ2B7Syx0TwAkE+Mz
         mcKI8Aahv7+UWuWm7XN0bBc651JpTVnSxqYKq2gK47zVeuiuzSA2GqRCPXTnSMS02jsw
         dfLgm2hx5jBnCGeOttvdzZm+zgH0t4DKxQa5UrEZD9ppjI0zUySfFvz0iseRDyx2xH4b
         fSfALl7/Q0czeWPCqjd2ygT2o2l+JUMyrwrFdQaWErJKL9GIw/Foltu/S8HJVLHE26+H
         qJ5hjmDhcqUSz+IcL80NJya72/F5sUobdUZzc1vMFsWpsym1bL41Y4G9uzoONJxREw86
         xsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uJ4VaOT8ap7MxQeWLu8CCH/zVyGcddyQFtuX8XLS83o=;
        b=sU7dJ9kUAEm5BGDOhiNkQCCelREkP6xnXDeGH3EEcvjdZaEX2Rch9uyfvlyL01rFd3
         ZLKlpVABYu4gzkrvtUlXzuyXDsg4dsRfK5jn9PJpHKAlXB+2RvDq/GAvvIUMVHcqsjI7
         gCDuI9O8bU37mCK0eNeN0pTzNrJrMo6YVJRlmVXd9anEjgztGl5ni0YBHh27YPgkcSIL
         W3nzSYSvgGnU401PhKOrBH/lmYprCTaeVgFhF3HzCspXRkyJKYHxw8kZnNEmkr61/4am
         /Q3RYK0cTviyBu1s0Q6lOwiv0sfcZ3H/rSpYFt/leKf+NrE9SVWDVvfCTgQHbQWI3ckL
         ziuA==
X-Gm-Message-State: ANhLgQ19uISl/qoue8/DHim3FTeYMbz/JuKMtxMkEnjajqbyogvo2V+n
        RQfwtpnZ7YF+aWTAsfb4AnE=
X-Google-Smtp-Source: ADFU+vv9JbF625u+JiDGSAXqTbGGUB8R60fIVB07qaki79GauoZyU/1bSnWVQFVD5RBHGvSz6Av44A==
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr3995508qkg.442.1583341852743;
        Wed, 04 Mar 2020 09:10:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:16fa])
        by smtp.gmail.com with ESMTPSA id n38sm11718564qtf.36.2020.03.04.09.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:10:52 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:10:51 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
Message-ID: <20200304171051.GK189690@mtj.thefacebook.com>
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
 <20200304163044.GF189690@mtj.thefacebook.com>
 <20200304100231.2213a982@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304100231.2213a982@lwn.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 04, 2020 at 10:02:31AM -0700, Jonathan Corbet wrote:
> On Wed, 4 Mar 2020 11:30:44 -0500
> Tejun Heo <tj@kernel.org> wrote:
> 
> > > (In a realistic scenario I expect to have swap and then reserving maybe
> > > a few hundred MiB; DAMON might help with finding good values.)  
> > 
> > What's DAMON?
> 
> 	https://lwn.net/Articles/812707/

Ah, thanks a lot for the link. That's neat. For determining workload
size, we're using senpai:

 https://github.com/facebookincubator/senpai

Thanks.

-- 
tejun
