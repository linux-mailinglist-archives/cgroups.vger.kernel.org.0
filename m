Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775931F48DB
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2020 23:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgFIV1h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Tue, 9 Jun 2020 17:27:37 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37272 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIV1g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Jun 2020 17:27:36 -0400
Received: by mail-ej1-f65.google.com with SMTP id mb16so224991ejb.4
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2020 14:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=kwegRFKyFAuFQmSuL2ErdFUJzcaqDng93wl658gpK9o=;
        b=ql/YBHQTv6tU9l5YdgfkHSpgFDzF4dWFgl25f8IsOdheo5OF47bB1h4fURTa7RAq+N
         hWAcrE6tC4TXmZPQiJW3pTJXQOYYLRrBXUt4uFjOw8L1LmWvWdMsbz1yemthAzE4zk/T
         sjjXQdOv/bKPb4diLNUkGGUKX+X7f7hiN6K+5HV4ox4EhAfzaYDnEJzklPRpzGQk0YO5
         0W9UCZbT9nPXMPG3y4xFjLvRkLBMYqUA7dcGlui2T/uQR6o2PIoUPyhwUcZ79rp6RtNF
         ykUUQ4mU6TGFQFd4TsatYq/1pZbAHX+NQ3Wn57zUFjmnaUPJ2RSoWRIx1jC2t3cBqWUS
         OEjw==
X-Gm-Message-State: AOAM530/Vb3QLeONyqmnIlAMenSdH5ds7YB9bqQg1IrxyA3JyPdArpDv
        CjXwsC2j/NOaVs+ur8s5Izm2GQ==
X-Google-Smtp-Source: ABdhPJyVDXx3Dhf2Kwdwhhcfh5ANIFfgHEr17WhF+CgZDw1jh+kJjVlK5XO6QkA+VMcgmOlx1ahUXQ==
X-Received: by 2002:a17:906:784c:: with SMTP id p12mr333740ejm.123.1591738054450;
        Tue, 09 Jun 2020 14:27:34 -0700 (PDT)
Received: from Google-Pixel-3a.fritz.box (ip5f5af183.dynamic.kabel-deutschland.de. [95.90.241.131])
        by smtp.gmail.com with ESMTPSA id b21sm14245223ejz.28.2020.06.09.14.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 14:27:33 -0700 (PDT)
Date:   Tue, 09 Jun 2020 23:27:30 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <202006091346.66B79E07@keescook>
References: <20200603011044.7972-1-sargun@sargun.me> <20200603011044.7972-2-sargun@sargun.me> <20200604012452.vh33nufblowuxfed@wittgenstein> <202006031845.F587F85A@keescook> <20200604125226.eztfrpvvuji7cbb2@wittgenstein> <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal> <202006091235.930519F5B@keescook> <20200609200346.3fthqgfyw3bxat6l@wittgenstein> <202006091346.66B79E07@keescook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to move fds across processes
To:     containers@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>
CC:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        John Fastabend <john.r.fastabend@intel.com>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, cgroups@vger.kernel.org,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On June 9, 2020 10:55:42 PM GMT+02:00, Kees Cook <keescook@chromium.org> wrote:
>On Tue, Jun 09, 2020 at 10:03:46PM +0200, Christian Brauner wrote:
>> I'm looking at __scm_install_fd() and I wonder what specifically you
>> mean by that? The put_user() seems to be placed such that the install
>> occurrs only if it succeeded. Sure, it only handles a single fd but
>> whatever. Userspace knows that already. Just look at systemd when a
>msg
>> fails:
>> 
>> void cmsg_close_all(struct msghdr *mh) {
>>         struct cmsghdr *cmsg;
>> 
>>         assert(mh);
>> 
>>         CMSG_FOREACH(cmsg, mh)
>>                 if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type
>== SCM_RIGHTS)
>>                         close_many((int*) CMSG_DATA(cmsg),
>(cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int));
>> }
>> 
>> The only reasonable scenario for this whole mess I can think of is sm
>like (pseudo code):
>> 
>> fd_install_received(int fd, struct file *file)
>> {
>>  	sock = sock_from_file(fd, &err);
>>  	if (sock) {
>>  		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
>>  		sock_update_classid(&sock->sk->sk_cgrp_data);
>>  	}
>> 
>> 	fd_install();
>> }
>> 
>> error = 0;
>> fdarray = malloc(fdmax);
>> for (i = 0; i < fdmax; i++) {
>> 	fdarray[i] = get_unused_fd_flags(o_flags);
>> 	if (fdarray[i] < 0) {
>> 		error = -EBADF;
>> 		break;
>> 	}
>> 
>> 	error = security_file_receive(file);
>> 	if (error)
>> 		break;
>> 
>> 	error = put_user(fd_array[i], ufd);
>> 	if (error)
>> 		break;
>> }
>> 
>> for (i = 0; i < fdmax; i++) {
>> 	if (error) {
>> 		/* ignore errors */
>> 		put_user(-EBADF, ufd); /* If this put_user() fails and the first
>one succeeded userspace might now close an fd it didn't intend to. */
>> 		put_unused_fd(fdarray[i]);
>> 	} else {
>> 		fd_install_received(fdarray[i], file);
>> 	}
>> }
>
>I see 4 cases of the same code pattern (get_unused_fd_flags(),
>sock_update_*(), fd_install()), one of them has this difficult
>put_user()
>in the middle, and one of them has a potential replace_fd() instead of
>the get_used/fd_install. So, to me, it makes sense to have a helper
>that
>encapsulates the common work that each of those call sites has to do,
>which I keep cringing at all these suggestions that leave portions of
>it
>outside the helper.
>
>If it's too ugly to keep the put_user() in the helper, then we can try
>what was suggested earlier, and just totally rework the failure path
>for
>SCM_RIGHTS.
>
>LOL. And while we were debating this, hch just went and cleaned stuff
>up:
>
>2618d530dd8b ("net/scm: cleanup scm_detach_fds")
>
>So, um, yeah, now my proposal is actually even closer to what we
>already
>have there. We just add the replace_fd() logic to __scm_install_fd()
>and
>we're done with it.

Cool, you have a link? :)

Christian
