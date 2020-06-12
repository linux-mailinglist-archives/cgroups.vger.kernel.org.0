Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4111F7CFE
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 20:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgFLSig (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 14:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFLSif (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jun 2020 14:38:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A9C08C5C1
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2020 11:38:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h185so4711439pfg.2
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2020 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JT8oJD0kpQknzBVSZP3Z/2D3ZlbgWd1By/OrwYLAa6A=;
        b=U10uEEViSocGeq7huvYZniWsLdXbFGNHeYYlLoO3+rCSFg9w1WEquFmb4W0zY7AZRD
         E7CNqC0dJexgTuH0Pvbo+SiLE0vHNH+ueUP892gN+69vPCV8rxhH63Lt+KnEyoie9TcW
         vdeYY9cIoIja/EdttRdHl0Rn+8mzjxjoaLVdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JT8oJD0kpQknzBVSZP3Z/2D3ZlbgWd1By/OrwYLAa6A=;
        b=I9utE9+bgI/pTNzZOvpSA9080muzfS8rrHK9JCIQd7FeBl1+Csad9kx7S3Dfom6YtT
         Ce46j70i4IpbUooYsNIACqmTQW37LBiJ/S2SAUzHWlD042zApJI4OO8n3B8+yUJT0SzK
         HmeIimERcxhc4BOHcl18v6K6+C0TdHwfGUubH6UeaIxiNzcM5jY+qXuxj0swWbgwqunJ
         0PEO87eb+wqrSZAZXhb9TmtTwxxjEKr5mesLAn7rk1sHw08aKlbAqP4Qt+H3wyeWdSBG
         C8OSJNWQn4AfLb/BOnKnrsIaxk9Fkc4X0yrybokvM89q9ycB5BDuT/JA945p675sOH88
         oMmA==
X-Gm-Message-State: AOAM53293u7/FtCQGZiSJObubWLu8+tgUzV7Q1hAApFqAtRL3nQdsVSF
        haZNR6goNO2eejUuPuj1Pn0f4Q==
X-Google-Smtp-Source: ABdhPJxqo9pw2SnNEw7Q+uwQoTXg4EJ3DvRdwks/Cd6J8XTSoLzwuge6CNDIg3djNR2nRGuVm+7dsA==
X-Received: by 2002:a63:ff51:: with SMTP id s17mr10439801pgk.300.1591987115224;
        Fri, 12 Jun 2020 11:38:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7sm4266581pfn.147.2020.06.12.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:38:34 -0700 (PDT)
Date:   Fri, 12 Jun 2020 11:38:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>, Tejun Heo <tj@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006121135.F04D66DFA@keescook>
References: <20200610081237.GA23425@ircssh-2.c.rugged-nimbus-611.internal>
 <202006101953.899EFB53@keescook>
 <20200611100114.awdjswsd7fdm2uzr@wittgenstein>
 <20200611110630.GB30103@ircssh-2.c.rugged-nimbus-611.internal>
 <067f494d55c14753a31657f958cb0a6e@AcuMS.aculab.com>
 <202006111634.8237E6A5C6@keescook>
 <94407449bedd4ba58d85446401ff0a42@AcuMS.aculab.com>
 <20200612104629.GA15814@ircssh-2.c.rugged-nimbus-611.internal>
 <202006120806.E770867EF@keescook>
 <20200612182816.okwylihs6u6wkgxd@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612182816.okwylihs6u6wkgxd@wittgenstein>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 12, 2020 at 08:28:16PM +0200, Christian Brauner wrote:
> Al didn't want the PAGE_SIZE limit in there because there's nothing
> inherently wrong with copying insane amounts of memory.

Right, ok.

> (Another tangent. I've asked this on Twitter not too long ago: do we
> have stats how long copy_from_user()/copy_struct_from_user() takes with
> growing struct/memory size? I'd be really interested in this. I have a
> feeling that clone3()'s and - having had a chat with David Howells -
> openat2()'s structs will continue to grow for a while... and I'd really
> like to have some numbers on when copy_struct_from_user() becomes
> costly or how costly it becomes.)

How long it takes? It should be basically the same, the costs should be
mostly in switching memory protections, etc. I wouldn't imagine how many
bytes being copied would matter much here, given the sub-page sizes.

> > Ah yeah, I like this because of what you mention below: it's forward
> > compat too. (I'd just use the ioctl masks directly...)
> > 
> > 	switch (cmd & ~(_IOC_SIZEMASK | _IOC_DIRMASK))
> > 
> > > 		return seccomp_notify_addfd(filter, buf, _IOC_SIZE(cmd));
> > 
> > I really like that this ends up having the same construction as a
> > standard EA syscall: the size is part of the syscall arguments.
> 
> This is basically what I had proposed in my previous mail, right?

I guess I missed it! Well, then I think we're all in agreement? :)

-- 
Kees Cook
