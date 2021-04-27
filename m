Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF25B36C7C2
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhD0O3q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 10:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhD0O3q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 10:29:46 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD786C061574
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 07:29:02 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id h15so19244329qvu.4
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UMKXl6Gx8KBkOWI3gUemjqjUZmjyHB6+YGIl3pR8iV4=;
        b=UjHG5sqhBTRbA7JGAGdLtiLjXzdXOPVB91HOJnd9Af9EJt2ivK+cpHpMc3DF1jMCYh
         cscFht7exVuPnY5gdsxHMWXu9ox7qddVgaVG/Rwlb6lSMgX+iH0bZe/tY7rnHN6paJDg
         v8fFOwLI0CKePjTVtutLeCXTUqPuJAkf+xxTozM+HCfL4a6beD8aDNgdnQjUyNwKQqKq
         vtqDsHr1w6MShr+Ak4P9NT3ZzOCrG05utQj1creMV5Ltll51StvIU1J3PYRElodrEv+j
         OaExalWKtGxF5yUOogdCsGVH1IFYYnQrEQBF/BD1uy+4fCeIhwOL0wVzYhVGCyx2JzvG
         IpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UMKXl6Gx8KBkOWI3gUemjqjUZmjyHB6+YGIl3pR8iV4=;
        b=dgkAEJooc6pXoT6PkUhlktVSMCMqvLX54F/2i/hNoZGLGJxbI0KUcE3A0S2LXKyuk1
         wbUjW4Zw1Ix3TQ5AjpIxkLUgK8ElaqBFWR02J+gkZQitjeYt2k4ut+b1hRQh73d9hBuJ
         sqBKqiqBdN4TELPIRfH/Iqcn/V5t1l8CH+M57RsVJFofoA5UxyHv0d7W12lxwVaRgzCJ
         chPYMpqY5ClyO02r+10ooXrrhzu7QvQR9ZiR+FtuivaVrktPhSZAt5KsDd/gOqVGu57m
         dtCPem7LOIyPvQWxS8CfLrogxj9VOApTzSunJixYEGeVdUsvnZ4n35tiMZYGZiXTR2Jf
         RqFg==
X-Gm-Message-State: AOAM53167hcFIijkWBSXB6QvnbaJ2yi5UPpb6vlE8LSVqNCp7CocXDGa
        N+w9VySYX/DqQ/0fhrdPYjQ=
X-Google-Smtp-Source: ABdhPJyrXQENHKwp1aoFbz8dYQ4x0w2820mlw/j6TOCB9jcrmO19WkoppCmRo6LMJEx3EzdpSe0Whg==
X-Received: by 2002:ad4:562d:: with SMTP id cb13mr8410678qvb.26.1619533741928;
        Tue, 27 Apr 2021 07:29:01 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id h193sm2804352qke.90.2021.04.27.07.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 07:29:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Apr 2021 10:29:00 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <YIgfrP5J3aXHfM1i@slm.duckdns.org>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIcOZEbvky7hGbR1@blackbook>
 <20210427093606.kygcgb74otakofes@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427093606.kygcgb74otakofes@wittgenstein>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Apr 27, 2021 at 11:36:06AM +0200, Christian Brauner wrote:
> I thought about this optimization but (see below) given that it should
> work with threaded cgroups we can't only walk thread-group leaders,
> afaiu.

CSS_TASK_ITER_PROCS|CSS_TASK_ITER_THREADED iterates all thread group leaders
in the threaded domain and is used to implement cgroup.procs. This should
work, right?

> > > @@ -4846,6 +4916,11 @@ static struct cftype cgroup_base_files[] = {
> > > +	{
> > > +		.name = "cgroup.signal",
> > > +		.flags = CFTYPE_NOT_ON_ROOT,
> > > +		.write = cgroup_signal_write,
> > 
> > I think this shouldn't be visible in threaded cgroups (or return an
> > error when attempting to kill those).
> 
> I've been wondering about this too but then decided to follow freezer in
> that regard. I think it should also be fine because a kill to a thread
> will cause the whole thread-group to be taken down which arguably is the
> semantics we want anyway.

I'd align it with cgroup.procs. Killing is a process-level operation (unlike
arbitrary signal delivery which I think is another reason to confine this to
killing) and threaded cgroups should be invisible to process-level
operations.

Thanks.

-- 
tejun
