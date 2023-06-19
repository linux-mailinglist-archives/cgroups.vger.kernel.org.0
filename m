Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186B5735D2C
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFSRxR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFSRxP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 13:53:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D8B12A;
        Mon, 19 Jun 2023 10:53:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC6CE216DC;
        Mon, 19 Jun 2023 17:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687197192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZIuFur/HcfWhT5DdI6dfHnQIRvcQlNpf5jwJtp/eN3s=;
        b=Re5KD9WLu+GeYv4h//LoyjUWFxbB9Iu1ah46eFj8lnpcZygGjrd8KMsnjy5+wFPb5rtsDW
        DpwXdSQWAlFSQoSh4P6p0i8dN6aUpYgv3C3Vobf/+qfFnJexoAU+cXDCd/C083H3oliYOf
        iHkT4rAB8xCQQrePLXgYRe0OT0azyTY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A04D9139C2;
        Mon, 19 Jun 2023 17:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3KNLJgiWkGT5fwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 19 Jun 2023 17:53:12 +0000
Date:   Mon, 19 Jun 2023 19:53:11 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Josh Don <joshdon@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>
Subject: Re: [PATCH v2 2/2] sched: add throttled time stat for throttled
 children
Message-ID: <rs46fzspb2w46zcbgdjysqd2rcfqs4yk55xyf5syvnf75rjhfe@ku6i5chn5qrq>
References: <20230612232748.3948659-1-joshdon@google.com>
 <20230612232748.3948659-2-joshdon@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icuc2q4jvzwybeqp"
Content-Disposition: inline
In-Reply-To: <20230612232748.3948659-2-joshdon@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--icuc2q4jvzwybeqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 04:27:48PM -0700, Josh Don <joshdon@google.com> wrote:
> We currently export the total throttled time for cgroups that are given
> a bandwidth limit.

I assume you refer to cpu.stat:throttled_usec (from struct
cfs_bandwidth) -- notice that the value is not properly hierarchical
despite v2 filename.

> This patch extends this accounting to also account the total time that
> each children cgroup has been throttled.

IIUC, this is visible on inner-nodes cpu cgroups (i.e. with no tasks)?

IOW, wouldn't you get the intended information if hierarchical summing
was added/fixed for cpu.stat:throttled_usec?

Thanks,
Michal

--icuc2q4jvzwybeqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZJCWBQAKCRAGvrMr/1gc
joqPAP9/BBtJGar7Rx1bCxiaeV7A8Au3XlzUAVHwxn9zARidBQEA3vGFSuyZNsXN
mKBFqLKkUlhCp6znAuvFIB3pq5frRAk=
=P/O2
-----END PGP SIGNATURE-----

--icuc2q4jvzwybeqp--
