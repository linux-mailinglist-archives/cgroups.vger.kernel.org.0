Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467A74F4276
	for <lists+cgroups@lfdr.de>; Tue,  5 Apr 2022 23:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiDEOKU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Apr 2022 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382804AbiDEMQ6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Apr 2022 08:16:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB75A94C8
        for <cgroups@vger.kernel.org>; Tue,  5 Apr 2022 04:27:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 613701F390;
        Tue,  5 Apr 2022 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649158064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S4RYhhYYgL2nQUXq/1MYpaBKBxeBnU3Dj31ERHGSis8=;
        b=qtPQqZC1moA5TLgAvs7AZe9Ksa/HPjEqpo3mBs5dL2NYE66pYPmmw3R9brwHzd4EtNSzZY
        0aSQsTeOmrOeLCMddapTYRluiqgu411jHFwFT1TZrgu6X03epsdtSmYOIj2GYEcKR/QTBS
        RagW8WedBfSTyebZ0lMgh+uNP88yk1k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F4AF13522;
        Tue,  5 Apr 2022 11:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id adaOErAnTGKTcAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 05 Apr 2022 11:27:44 +0000
Date:   Tue, 5 Apr 2022 13:27:43 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     "R. Diez" <rdiez1999@gmail.com>
Cc:     cgroups mailinglist <cgroups@vger.kernel.org>
Subject: Re: Wrapper to run a command in a temporary cgroup
Message-ID: <20220405112743.GC13806@blackbody.suse.cz>
References: <0174490d-8679-3885-df31-e9f6c1e7205b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0174490d-8679-3885-df31-e9f6c1e7205b@gmail.com>
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

Hello.

On Mon, Apr 04, 2022 at 02:25:27PM +0200, "R. Diez" <rdiez1999@gmail.com> wrote:
> run-on-temporary-cgroup.sh cmd arg1 ... argn.
> 
> The tool should create a temporary cgroup, run the process inside, and
> return the same exit code as the user command.

This sounds very much like `systemd-run --scope`.

> Those requirements are similar to what systemd-run does, but I need an
> alternative which does not depend on systemd.

Fair enough.

> Even if you have systemd, systemd-run is rather convenient, but it is
> somewhat heavy weight 

Then a suggestion of using a container runtime is likely out of question
too.

> If there is no such a tool, can someone give me some hints on how to
> implement one? Is it possible in Shell or Perl? Or do I need to reach
> to C / C++? Is there anything similar I could take as basis?

There's also libcg [1] (whose cgroup v2 support is WIP AFAIK) with its
cgexec utility. I don't know other tools (besides the named previously).

You can implement it in whatever environment that can interact with
filesystem (and perhaps poll for events), it's all documented in [2]
(alternatively [3], which I'd discourage for a new project).

HTH,
Michal

[1] https://github.com/libcgroup/libcgroup/blob/main/README
[2] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html
[3] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v1/cgroups.html

