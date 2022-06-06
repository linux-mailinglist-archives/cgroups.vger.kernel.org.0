Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBFC53EE02
	for <lists+cgroups@lfdr.de>; Mon,  6 Jun 2022 20:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiFFSno (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jun 2022 14:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiFFSno (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jun 2022 14:43:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3487B1A3598;
        Mon,  6 Jun 2022 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654541023; x=1686077023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zBGk5qIFMqfmDlZW092e3SVIsz61LPw9vTaFM7k3klM=;
  b=orIbPEgg2DQ6ZywvWiICzRipAfzZvFmhWlFY1h686HxZICe0IxqzQxKa
   1l6aWalGQ65yCRbXnglPxVEZfP9OCw7TwY9KYQdRikzNsIhMxHLq967+F
   yuVbg9bvVRgsEvnJYatEMGVHbKYhWjuKeJkz2G+XY+Qqqb6wQDrL+iB2f
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2022 11:43:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 11:43:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 11:43:42 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 11:43:40 -0700
Date:   Mon, 6 Jun 2022 14:43:38 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Vasily Averin <vvs@openvz.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <kernel@openvz.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH memcg v6] net: set proper memcg for net_init hooks
 allocations
Message-ID: <Yp5K2iupKdVdQXUc@qian>
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
 <Yp4F6n2Ie32re7Ed@qian>
 <0e714a5a-d2ed-9b44-fdbe-04b5595165da@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e714a5a-d2ed-9b44-fdbe-04b5595165da@openvz.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 06, 2022 at 08:37:26PM +0300, Vasily Averin wrote:
> On 6/6/22 16:49, Qian Cai wrote:
> > This triggers a few boot warnings like those.
> > 
> >  virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)
> >  WARNING: CPU: 87 PID: 3170 at arch/arm64/mm/physaddr.c:12 __virt_to_phys
> 
> Thank you for reporting the problem,
> Could you please provide me your config file via private email?

$ make ARCH=arm64 defconfig debug.config
