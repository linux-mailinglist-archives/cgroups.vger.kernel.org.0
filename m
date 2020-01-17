Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6152B140F55
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2020 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgAQQxQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jan 2020 11:53:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42354 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQQxQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jan 2020 11:53:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so22236071qtq.9;
        Fri, 17 Jan 2020 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yuUv1OXPdVXWCIetDO046G9cCpe5yN5/7bZ6LwPz4B0=;
        b=qejqoYN8Ckgk98zDdvv5t54CTIJkmQNW8KtQRyuyEU5uMhUYYKKdT62/lehyI7sVJm
         qDJZ79DuRMyEyQ5o4Sh/7vvL5aHNSe/eGoS0al+CWlnzItuoZmCOirDYyqSxEDCMdULT
         KMOPWsJfXCxADqkxSg3zY36dU/UpJqlnGRoyFbac5jbYRQUByodAZngML6pRT7ATH01E
         VQnhvcD0HAZSbw7aP5UlTlCFkCxiR7SbsQkQHmQ0s5TuN0SBNFPHY6A/V0/y9Uscci6n
         EeCF2xh5jqi4sRdsIwmsa6b0NditLe5KWesqcI88MZv6SzbmERB6gu6sNYB3BpWuVxhb
         SKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yuUv1OXPdVXWCIetDO046G9cCpe5yN5/7bZ6LwPz4B0=;
        b=b9zJ22Dh8kEjRg8ts3PG2wyjQJ6zOxGZLUY/ETtCrupepWMZRknPN/6lrtR5289nm3
         9wpQNRxjfm8paa3Uc3SjYGhYthUVYILIHDQNWd18wZlVJw42ot1rjDC8Y01tM1mJazgz
         JbmNGaDmkxnstUZSrfjmToQzGxt8RwKOL4fsO14gUNcsXsknYWpyTHs2U28uDi3aAqNS
         PwVeqNmNdw7gaQc9nw/G3poaKWKLPecHJojuH9OWDM/j1gGLc5jJwJ9EmpBPocF6dh8Z
         2vS6+tOJZ6kPBA3deB/Cwj+VDuNZKNXV2i69cMTnwEEWnwf2XEEk6qNZTrY6nsMv7B0L
         1X8Q==
X-Gm-Message-State: APjAAAUpebE/ErzPUY312c16yWYkp+G9JRyFR8IQ5oFjTPRnEAECx0cJ
        vv9u0wkHpZ/Zao+MY4bxw/0=
X-Google-Smtp-Source: APXvYqzeqNYl3PDuAsOWUjZm+WEOTe7nEQaEy/4qU5UBYITUMTORCCIXd/KpbM11ytW1Gz0pKvbUzg==
X-Received: by 2002:ac8:21fd:: with SMTP id 58mr8021334qtz.90.1579279994927;
        Fri, 17 Jan 2020 08:53:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:7d10])
        by smtp.gmail.com with ESMTPSA id l17sm12141256qkk.22.2020.01.17.08.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 08:53:14 -0800 (PST)
Date:   Fri, 17 Jan 2020 08:53:11 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20200117165311.GH2677547@devbig004.ftw2.facebook.com>
References: <20191223061504.28716-1-christian.brauner@ubuntu.com>
 <20191223061504.28716-3-christian.brauner@ubuntu.com>
 <20200107163204.GB2677547@devbig004.ftw2.facebook.com>
 <20200108180906.l4mvtdmh7nm2z7sc@wittgenstein>
 <20200116122944.nj3e66eusxu6sb44@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116122944.nj3e66eusxu6sb44@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Christian.

Sorry about late reply.

On Thu, Jan 16, 2020 at 01:29:44PM +0100, Christian Brauner wrote:
> Could it be that you misread cgroup_attach_permissions()? Because it
> does check for write permissions on the destination cgroup.procs file.
> That's why I've added the cgroup_get_from_file() helper. :) See:
> 
> static int cgroup_attach_permissions(struct cgroup *src_cgrp,
> 				     struct cgroup *dst_cgrp,
> 				     struct super_block *sb, bool thread)
> {
> 	int ret = 0;
> 
> 	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
> 	if (ret)
> 		return ret;

So, if you look at cgroup_procs_write_permission(), it's only checking
the write perm of the common ancestor, not the destination because it
assumes that the destination is already checked by the vfs layer, and
we need to check both.

Thanks.

-- 
tejun
