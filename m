Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF27ABCB
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2019 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbfG3PBW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Jul 2019 11:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbfG3PBW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 30 Jul 2019 11:01:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820EA206A2;
        Tue, 30 Jul 2019 15:01:20 +0000 (UTC)
Date:   Tue, 30 Jul 2019 11:01:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
Message-ID: <20190730110118.36853a8b@gandalf.local.home>
In-Reply-To: <80fbaf63ddbe66cbbf3391256402295af1a3336f.camel@perches.com>
References: <20190729151346.9280-1-hslester96@gmail.com>
        <201907292117.DA40CA7D@keescook>
        <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
        <80fbaf63ddbe66cbbf3391256402295af1a3336f.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 30 Jul 2019 00:03:28 -0700
Joe Perches <joe@perches.com> wrote:

> I believe I'm still in favor of global conversion of
> strstarts to str_has_prefix.
> 

So am I.

-- Steve
