Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4C4D98E4
	for <lists+cgroups@lfdr.de>; Tue, 15 Mar 2022 11:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbiCOKhI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Mar 2022 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiCOKhI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Mar 2022 06:37:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA53B4504B
        for <cgroups@vger.kernel.org>; Tue, 15 Mar 2022 03:35:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 645D71F397;
        Tue, 15 Mar 2022 10:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647340555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MLqG2jYAqMJVFGVl9uQo/qZHJDtNUCqj95IKfyjlIs=;
        b=HQerq55GnNl/XQ/47+SzBS7xttc161pt08lvmSb65Z8HOxQdpYo3rQ1TQAu7rHp5l2uc0Z
        Ruy1QXyd1k2jFE5OO+7fRimcoMYEDvRIlALar+HLfhb30Wd2PXPs60TvYFjtsyesugSU7h
        6ALDxYxT90jysW1JwcMW6c4vqQiUT1s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40A6413B59;
        Tue, 15 Mar 2022 10:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIyYDgtsMGLaIAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 15 Mar 2022 10:35:55 +0000
Date:   Tue, 15 Mar 2022 11:35:53 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Olsson John <john.olsson@saabgroup.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Split process across multiple schedulers?
Message-ID: <20220315103553.GA3780@blackbody.suse.cz>
References: <b5039be462e8492085b6638df2a761ca@saabgroup.com>
 <20220314164332.GA20424@blackbody.suse.cz>
 <bf2ea0888a9e45d3aafe412f0094cf86@saabgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2ea0888a9e45d3aafe412f0094cf86@saabgroup.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 15, 2022 at 08:19:26AM +0000, Olsson John <john.olsson@saabgroup.com> wrote:
> If I'm understanding you correctly this effectively means that it is
> possible to spread a process and its threads across multiple cgroups
> that in turn may have different schedulers (and CPU affinity)
> associated with them?

Yes, the docs is here
https://www.kernel.org/doc/html/v5.17-rc8/admin-guide/cgroup-v2.html#threads

> > (Without CONFIG_RT_GROUP_SCHED all RT threads are effectively in the
> > root cgroup.)
> 
> Interesting! I have missed this little tidbit of information. This is
> indeed very good to know!

Maybe I should have added this applies from the POV of the cpu
controller in particular...

> A side effect of this is that in V2 you can't have an RT thread pinned
> to a specific core that is evacuated, right?

...it has no effect for grouping of cpuset controller (assuming both cpu
and cpuset are enabled in given subtree).

> If you could do this it would also be possible to remove the portion
> of the scheduling interval that is left for non-RT threads in the
> cgroup config since there would not be any other threads on this
> evacuated core.
> By doing that you would eliminate jitter due to that otherwise the
> scheduler would interrupt the RT thread and immediately re-schedule it
> again. And thus you would theoretically get very good RT properties
> (unless you make system calls).

Well, there are more jobs that can interfere with RT workload on a cpu
(see isolcpus= [1]) and there's some ongoing work to make these more
convenient via cpuset controller [2]. The currently working approach
would be to use isolcpus= cmdline to isolate the CPUs and use either
sched_setaffinity() or cpuset controller to place tasks on the reserved
CPUs (the cpuset approach is more strict as it may prevent unprivileged
threads to switch to another CPU). 

> If you instead used FIFO scheduling (which handles RT threads only,
> right?) then you could eliminate this noise. Or I am just showing off
> how little I understand about scheduling in Linux. ;)

(Actually when I take a step back and read your motivational example of
a legacy game in VM, I don't think FIFO (or another RT policy) is suited
for this case. Plain SCHED_OTHER and cpu controller's bandwidth
limitation could do just fine -- you can apply to a (threaded) cgroup
with chosen threads only.)

HTH,
Michal


[1] https://www.kernel.org/doc/html/v5.17-rc8/admin-guide/kernel-parameters.html?highlight=isolcpus
[2] https://lore.kernel.org/all/20211205183220.818872-1-longman@redhat.com/
