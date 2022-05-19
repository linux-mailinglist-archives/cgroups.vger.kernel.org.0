Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA552DAA8
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 18:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbiESQxf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbiESQxd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 12:53:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676CC66C84;
        Thu, 19 May 2022 09:53:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08AD521BA8;
        Thu, 19 May 2022 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652979207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6frXTBgzGRsjQpEWOm3xYp6acz/9cACY818c3GjmbTE=;
        b=aU4Zz5L96bfOjnVSWwfUl/ZOl+pAHsxcqe088kJSSjOLa4Lo/g4x6rXHcEeW56lZA8rXfn
        Zd72o8ccBgsUKXmWVf+tFT7ICCA3Xn7X1C1Dh3B73jS5NH59GNa1+Osny2pwZrHT6DYSl8
        I73RnhMuNCm9ZcgAXED12k4VMQysZuA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB63913456;
        Thu, 19 May 2022 16:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mAutMAZ2hmJHCgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 19 May 2022 16:53:26 +0000
Date:   Thu, 19 May 2022 18:53:25 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/4] memcg: enable accounting for struct cgroup
Message-ID: <20220519165325.GA2434@blackbody.suse.cz>
References: <Ynv7+VG+T2y9rpdk@carbon>
 <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17be77f-dc3b-d69a-16e2-f7309959c525@openvz.org>
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

On Fri, May 13, 2022 at 06:52:12PM +0300, Vasily Averin <vvs@openvz.org> wrote:
> Creating each new cgroup allocates 4Kb for struct cgroup. This is the
> largest memory allocation in this scenario and is epecially important
> for small VMs with 1-2 CPUs.

What do you mean by this argument?

(On bigger irons, the percpu components becomes dominant, e.g. struct
cgroup_rstat_cpu.)

Thanks,
Michal
