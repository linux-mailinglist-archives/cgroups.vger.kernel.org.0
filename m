Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D01B58DE
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2020 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgDWKOX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 06:14:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33089 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDWKOX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 06:14:23 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jRYs8-00021O-Rb; Thu, 23 Apr 2020 10:14:20 +0000
Date:   Thu, 23 Apr 2020 12:14:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] clone.2: Document CLONE_INTO_CGROUP
Message-ID: <20200423101420.udkmlhnfg57lsshi@wittgenstein>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200410104132.294639-1-christian@brauner.io>
 <b7550fcd-ba12-e64a-3228-e6668b31a8a7@gmail.com>
 <CAKgNAkhQr+sKGAu+KcxPEsuwG3kjQOyzVW7E1yM9cMtSZrhW9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKgNAkhQr+sKGAu+KcxPEsuwG3kjQOyzVW7E1yM9cMtSZrhW9A@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 21, 2020 at 04:30:46PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Christian,
> 
> Ping!

Will likely take a few days until I can get around to prepare a second
version. Sorry for the delay!

Christian
