Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892CE532A0F
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiEXMEg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiEXMEg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 08:04:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68842644F6;
        Tue, 24 May 2022 05:04:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 15F571F86A;
        Tue, 24 May 2022 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653393874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kt6lRreumMR82QxTIV2F0todF1CGcv8SrAK54H/AV8A=;
        b=W1eYCUa3Gc34WBARqY6Z4kLP1JcTMqeIR8a203LcNCcnfhIJGZXU4XvcbMblM5ifce7hs9
        l3qlXUc7EIsXHl2hRqLmWHxad74fKSX1lTrYgtR6v5CXB0yaCAo8dzWKeLQbCrKBaLnlp6
        Kptviaf5cYuvAYHoxvGS5a0rFRrmUoE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B9D2F2C141;
        Tue, 24 May 2022 12:04:33 +0000 (UTC)
Date:   Tue, 24 May 2022 14:04:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com
Subject: Re: [External] Re: [PATCH] mm: memcontrol: add the mempolicy
 interface for cgroup v2.
Message-ID: <YozJ0SNOjO3m4ehp@dhcp22.suse.cz>
References: <20220524103638.473-1-hezhongkun.hzk@bytedance.com>
 <Yoy3wDh0cvziWGHJ@dhcp22.suse.cz>
 <CACSyD1N4VeWBOzZwBogDW-wBbLvF54VrZ1Z+p9NFiXY+etuDJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1N4VeWBOzZwBogDW-wBbLvF54VrZ1Z+p9NFiXY+etuDJA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 24-05-22 19:46:38, 贺中坤 wrote:
> Hi Michal, thanks for your reply.
> mempolicy has two functions, which nodes to choose and how to use these
> nodes. cpuset can only decide the first one，it equal to 'bind' mempolicy.
> If cgroups support mempolicy, we can continue to develop more policy
> types. For example, allocate memory according to node weight, etc.
> We would like to have more precise control over memory allocation in NUMA
> server.

Why cputset controller cannot be extended instead?

-- 
Michal Hocko
SUSE Labs
