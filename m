Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68431D4D33
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgEOL7q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 07:59:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52939 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgEOL7q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 07:59:46 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jZZ0B-0000Kb-MV; Fri, 15 May 2020 11:59:43 +0000
Date:   Fri, 15 May 2020 13:59:42 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] clone.2: Document CLONE_INTO_CGROUP
Message-ID: <20200515115942.n2teqwvo3day6cvz@wittgenstein>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200410104132.294639-1-christian@brauner.io>
 <b7550fcd-ba12-e64a-3228-e6668b31a8a7@gmail.com>
 <CAKgNAkhQr+sKGAu+KcxPEsuwG3kjQOyzVW7E1yM9cMtSZrhW9A@mail.gmail.com>
 <20200423101420.udkmlhnfg57lsshi@wittgenstein>
 <CAKgNAkhXxWFE8msNkJ3117ChacWsfiMsBptZsVJOnxGtuDTX0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgNAkhXxWFE8msNkJ3117ChacWsfiMsBptZsVJOnxGtuDTX0Q@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 01:41:46PM +0200, Michael Kerrisk (man-pages) wrote:
> Hello Christian,
> 
> Ping!

Yes, I just thought of this when I saw your mail to Aleksa fly by. ;)
Christian
