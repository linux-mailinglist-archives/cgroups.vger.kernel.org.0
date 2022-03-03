Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047C4CC86D
	for <lists+cgroups@lfdr.de>; Thu,  3 Mar 2022 22:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiCCVyJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Mar 2022 16:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiCCVyJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Mar 2022 16:54:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006253EA9B
        for <cgroups@vger.kernel.org>; Thu,  3 Mar 2022 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sct51wRdcOdh4/CUtiuhNhf7LaEDw3Kb0tD5nil9ssQ=; b=nQ2RXZ8gjdMPqZZFrcN2/kZvXn
        n2AmG25tiHr4++jCKRm2sE9EKoOyPaJtTco1260U63kPyifVNs1XrwE+71B+kK3aGTKWmxs/kkIpw
        TQS5oy3EGHrZ9jsdz6w7xEFPyImfGl9k8+Z55esk3IGjcHMa/H+W+WKJQtQv/ivyg0OaWkrE2Vux2
        jMPabgJQA9VqX9qxQnqVN78uExie7OrDxuJj15gK8kOuOct3f7KG9GFaOzAuUeTmccXD8lrN+ohYB
        HBfNmGfOSExmZcUen/OyRCANVCPvOh/V4DWx5hZcNwOcaw4KDRkljKmgYdopoREE49Phzfp30prli
        L82857cA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPtNl-00C1KC-2x; Thu, 03 Mar 2022 21:53:09 +0000
Message-ID: <5130da56-0f22-8212-0ea3-6ddb8a8f5455@infradead.org>
Date:   Thu, 3 Mar 2022 13:53:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] mm/memcontrol: return 1 from cgroup.memory __setup()
 handler
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     linux-mm@kvack.org, Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
References: <20220222005811.10672-1-rdunlap@infradead.org>
 <20220302185300.GA19699@blackbody.suse.cz>
 <9f8d4ddb-81ce-738a-d1f7-346ff9bf8ebd@infradead.org>
 <20220303101406.GE10867@blackbody.suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220303101406.GE10867@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On 3/3/22 02:14, Michal Koutný wrote:
> On Wed, Mar 02, 2022 at 04:53:19PM -0800, Randy Dunlap <rdunlap@infradead.org> wrote:
>> I don't think those strings (even with invalid option values) should be
>> added to init's environment.
> 
> Isn't mere presence of the handler sufficient to filter those out? [1]

What is [1] here?

> (Counter-example would be 'foo=1 foo=2' where 1 is accepted value by the
> handler, 2 is unrecognized and should be passed to init. Is this a real
> use case?)

I don't know of any case where "foo=2" should be passed to init if
there is a setup function for "foo=" defined.

>> I'm willing to add a pr_warn() or pr_notice() for any unrecognized
>> option value, but it should still return 1 IMO.
> 
> Regardless of the handler existence check, I see returning 1 would be
> consistent with the majority of other memcg handlers.
> 
> For the uniformity,
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> 
> (Richer reporting or -EINVAL is by my understanding now a different
> problem.)

-- 
~Randy
