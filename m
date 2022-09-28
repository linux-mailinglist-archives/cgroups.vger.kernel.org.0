Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEE5EDBE8
	for <lists+cgroups@lfdr.de>; Wed, 28 Sep 2022 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiI1Li5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Sep 2022 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiI1Liz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Sep 2022 07:38:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14189103;
        Wed, 28 Sep 2022 04:38:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ACAE81F8A3;
        Wed, 28 Sep 2022 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664365133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYWIjI2zG6qx8PsHipWo2k/Bj8E69alY2jmp4fMvkIs=;
        b=eEu5aM3Q2HILLqqyiC30YRVrS5v1Z9lVjKfTJGXvx5Yt6gAGhiY0jYQMSLwApMmmUJ0ySe
        QHjPXTkEuUkOd1aZWjW6bDk0hh0xkgbmy1FM7U59KznTpM34r7dvbAtrPayJoCOy4q6yvw
        IaBQjeUZtHXa8cEXZ5xrDTEzuVPHF6Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 718ED13677;
        Wed, 28 Sep 2022 11:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nUF/Gk0yNGPlKAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 28 Sep 2022 11:38:53 +0000
Date:   Wed, 28 Sep 2022 13:38:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH cgroup/for-6.1] cgroup: Make cgroup_get_from_id() prettier
Message-ID: <YzQyTJVyG9LVUAp7@blackbook>
References: <20220923115119.2035603-1-ming.lei@redhat.com>
 <Yy3tEKSV+vg6swOd@slm.duckdns.org>
 <Yy3tjvIGd2j4wnSw@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy3tjvIGd2j4wnSw@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 23, 2022 at 07:31:58AM -1000, Tejun Heo <tj@kernel.org> wrote:
> Ming, Michal, you guys' changes to cgroup_get_from_id() combine to make
> cgroup_get_from_id() a bit too ugly, so I applied the following patch to
> cgroup/for-6.1. Please take a look and lemme know if I broke anything.

The cleanup looks good.

Just for the record, I understand the refernced fix is persisted as
> df02452f3df0 ("cgroup: cgroup_get_from_id() must check the looked-up kn is a directory")

Regards,
Michal
