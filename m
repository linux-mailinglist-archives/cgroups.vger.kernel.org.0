Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26017A845
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 15:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgCEOz6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 09:55:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40116 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCEOz6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 09:55:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id m2so5533905qka.7
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NOWIJylcLM+2xBd7NFNAk6brzU5tY0Fsm0nPExtQlys=;
        b=AQZExFJChAVsycjeW1vn8E/eFNQMwIQ/E1wOUbJyXyiI7yqeIO52aTGC2JoIicCOWZ
         1sUUROklG3EgdcJcdNxYI6oMbpXBFf8ZZJ+hBTfk499bLUpDrfe9aAm7NLl5daPr7MU1
         RlJ5LVkWr9PIBuZCoyWeiLsYf01bEW0/XfhNuL2n8J6BvqrYhd4C6dVjBnQDKjL7CVr2
         2iOP180GVHMGCeecqmRHLea0owluRkZIfYwVGJXE5GfQaGslPEOF3A1LVY4loo1c+GOI
         pxqQE+pv0oJwAhU/UAfSDyRJ/nllwVVp3it4CPf2Xz0zbfa0STQeJv8WIN+tRBFv0tj8
         0slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NOWIJylcLM+2xBd7NFNAk6brzU5tY0Fsm0nPExtQlys=;
        b=md4u5kPRlw8FgwnpexJTFOx7CuZ/LfnALKiieWAnj9MCiE6cFfDzcG1ct4oYnEV1WK
         1/1y0nOWdo9XawCSv4Z30Ym9bBrWKzmNbB9AL1TILqRD3Nkm7u2uuPlDL3hYrLESJ9ef
         genCYN20RBmK/cq5Sc6utUSj2cLwFwWX9MWHA+ZimPW9oU8zgkq3TkrYqjgJmFw4yJBy
         HZPjCFUMBaabOHsbboKFkTXUUxfWxKMcEUoUwvr6Blz2P6hjLW4N3Sp8+xuUwqVH9Rt4
         0Q/PekgyaZD321Zq71xy97ixtGNeKIUOgUt+d2Gj0wwqlDBZKkXInnQbthAbY1cV/Y4s
         nXFA==
X-Gm-Message-State: ANhLgQ2l9Bg7n60gX+evCiIVx7OFT6hUilaCQmlLuOkWmlxQ/f2sl5Ej
        /YznggmNP6eQTH5flhd4d6VVdFiMPfw=
X-Google-Smtp-Source: ADFU+vumIu4nB9uNeFZ8yVvaEoW2zgyv3RZnkrGIJ7cfWiBQ37DwPloM1PhIoUK4/O60V5KbM4k5Cg==
X-Received: by 2002:a37:6841:: with SMTP id d62mr8129473qkc.365.1583420156287;
        Thu, 05 Mar 2020 06:55:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e7c7])
        by smtp.gmail.com with ESMTPSA id g22sm1058992qtp.8.2020.03.05.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:55:55 -0800 (PST)
Date:   Thu, 5 Mar 2020 09:55:54 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
Message-ID: <20200305145554.GA5897@mtj.thefacebook.com>
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
 <20200304163044.GF189690@mtj.thefacebook.com>
 <4d3e00457bba40b25f3ac4fd376ba7306ffc4e68.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3e00457bba40b25f3ac4fd376ba7306ffc4e68.camel@sipsolutions.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Mar 05, 2020 at 02:13:58PM +0100, Benjamin Berg wrote:
> A major discussion point seemed to be that cgroups should be grouped by
> their resource management needs rather than a logical hierarchy. I
> think that the resource management needs actually map well enough to
> the logical hierarchy in our case. The hierarchy looks like:

Yeah, the two layouts share a lot of commonalities in most cases. It's
not like we usually wanna distribute resources completely unrelated to
how the system is composed logically.

>                          root
>                        /     \
>            system.slice       user.slice
>           /    |              |         \
>       cron  journal    user-1000.slice   user-1001.slice
>                               |                      \
>                       user@1000.service            [SAME]
>                         |          |
>                    apps.slice   session.slice
>                        |             |
>                   unprotected    protected
> 
...
> I think this actually makes sense. Both from an hierarchical point of
> view and also for configuring resources. In particular the user-.slice
> layer is important, because this grouping allows us to dynamically
> adjust resource management. The obvious thing we can do there is to
> prioritise the currently active user while also lowering resource
> allocations for inactive users (e.g. graphical greeter still running in
> the background).

Changing memory limits dynamically can lead to pretty abrupt system
behaviors depending on how big the swing is but memory.low and io/cpu
weights should behave fine.

> Note, that from my point of view the scenario that most concerns me is
> a resource competition between session.slice and its siblings. This
> makes the hierarchy above even less important; we just need to give the
> user enough control to do resource allocations within their own
> subtree.
> 
> So, it seems to me that the suggested mount option should work well in
> our scenario.

Sounds great. In our experience, what would help quite a lot is using
per-application cgroups more (e.g. containing each application as user
services) so that one misbehaving command can't overwhelm the session
and eventually when oomd has to kick in, it can identify and kill only
the culprit application rather than the whole session.

Thanks.

-- 
tejun
