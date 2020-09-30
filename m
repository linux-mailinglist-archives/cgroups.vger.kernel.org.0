Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8C27EF4F
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgI3QfA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 12:35:00 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:35802 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3Qe7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Sep 2020 12:34:59 -0400
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 08UGRCfc129285;
        Wed, 30 Sep 2020 19:34:37 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 33vwb280x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 19:34:37 +0300
Received: from tuxera.com (87.92.44.32) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Sep
 2020 19:34:36 +0300
Date:   Wed, 30 Sep 2020 19:34:35 +0300
From:   Jouni Roivas <jouni.roivas@tuxera.com>
To:     Tejun Heo <tj@kernel.org>
CC:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Zero sized write should be no-op
Message-ID: <20200930163435.GB304403@tuxera.com>
References: <20200928131013.3816044-1-jouni.roivas@tuxera.com>
 <20200930160357.GA25838@blackbody.suse.cz>
 <20200930160619.GE4441@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930160619.GE4441@mtj.duckdns.org>
X-Originating-IP: [87.92.44.32]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_09:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=1 malwarescore=0 adultscore=0 mlxlogscore=939
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300129
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

thanks for the feedback.

The 09/30/2020 12:06, Tejun Heo wrote:
> On Wed, Sep 30, 2020 at 06:03:57PM +0200, Michal Koutný wrote:
> > On Mon, Sep 28, 2020 at 04:10:13PM +0300, Jouni Roivas <jouni.roivas@tuxera.com> wrote:
> > > Do not report failure on zero sized writes, and handle them as no-op.
> > This is a user visible change (in the case of a single write(2)), OTOH,
> > `man write` says:
> > > If count is zero and fd refers to a file other than a regular file,
> > > the results are not specified.
> 
> So, I'm not necessarily against the change, mostly in the spirit of "why
> not?".

There's actual user space application failing because of this. Of course
can to fix the app, but think it's better to fix kernel as well. At
least prevents possible similar failures in future.

> > > @@ -3682,6 +3700,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
> > >  	struct cgroup_subsys_state *css;
> > >  	int ret;
> > >  
> > > +	if (!nbytes)
> > > +		return 0;
> > > +
> > >  	/*
> > >  	 * If namespaces are delegation boundaries, disallow writes to
> > >  	 * files in an non-init namespace root from inside the namespace
> > Shouldn't just this guard be sufficient? 
> 
> But yeah, please do it in one spot.

Thought it would be good to add everywhere, but will clean up the patch
and resubmit.
