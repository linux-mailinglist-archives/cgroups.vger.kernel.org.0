Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249D9406906
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhIJJYY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 05:24:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhIJJYX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 05:24:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D387022420;
        Fri, 10 Sep 2021 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631265791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxyNsNXpcaoyxBKXxrL/D1l4dorTQq9F7tfJh7pzbIo=;
        b=kYAeMRNqrK2eHW8Bx7E+FBsRJN1XYHIzivgkxEiakryLSLrDsy6FvBAEzVgC5JpU8OEJvk
        Dq84PXD+wNaMFFz5gxhbkp1IRbzyvgMej5zXNqlwkZe9WVMgq5A3cVrlcMjZZOGpUwKaBf
        PbaPXIsyAiDDmUACoSK1CkrKeVeDndw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF3D613D26;
        Fri, 10 Sep 2021 09:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MAlNKv8jO2HWcAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 10 Sep 2021 09:23:11 +0000
Date:   Fri, 10 Sep 2021 11:23:10 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     Vipin Sharma <vipinsh@google.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] misc_cgroup: remove error log to avoid log flood
Message-ID: <20210910092310.GA18084@blackbody.suse.cz>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <86e89df640f2b4a65dd77bdbab8152fa8e8f5bf1.1631077837.git.brookxu@tencent.com>
 <20210909143720.GA14709@blackbody.suse.cz>
 <CAHVum0ffLr+MsF0O+yEWKcdpR0J0TQx6GdDxeZFZY7utZT8=KA@mail.gmail.com>
 <YTpY0G3+IJYmGbdd@blackbook>
 <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478e986c-bc69-62b8-936e-5b075f9270b4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 10, 2021 at 01:30:46PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> I am a bit confused here. For misc_cgroup, we can only be rejected when the count
> touch Limit, but there may be other more reasons for other subsystems.

Sorry, I wasn't clear about that -- the failures I meant to be counted
here were only the ones caused by (an ancestor) limit. Maybe there's a
better naem for that.

> Therefore, when we are rejected, does it mean that we have touch
> Limit? If so, do we still need to distinguish between max and fail?
> (for misc_cgroup)

r
`- c1
   `- c2.max
       `- c3
          `- c4.max
	     `- task t
          `- c5

Assuming c2.max < c4.max, when a task t calls try_charge and it fails
because of c2.max, then the 'max' event is counted to c2 (telling that
the limit is perhaps low) and the 'fail' event is counted to c4 (telling
you where the troubles originated). That is my idea. Although in the
case of short-lived cgroups, you'd likely only get the hierarchically
aggregated 'fail' events from c3 or higher with lower (spatial)
precision.
What would be the type of information useful for your troubleshooting?

Cheers,
Michal
