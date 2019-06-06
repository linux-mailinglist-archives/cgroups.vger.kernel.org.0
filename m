Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B310636C18
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 08:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfFFGPi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 02:15:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfFFGPi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jun 2019 02:15:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5667a7c122227
        for <cgroups@vger.kernel.org>; Thu, 6 Jun 2019 02:15:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sxv7eaxs0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Thu, 06 Jun 2019 02:15:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <cgroups@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 6 Jun 2019 07:15:35 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 07:15:30 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x566FTuV17432996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 06:15:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 402574207B;
        Thu,  6 Jun 2019 06:15:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F234B4205E;
        Thu,  6 Jun 2019 06:15:27 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.53])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Jun 2019 06:15:27 +0000 (GMT)
Date:   Thu, 6 Jun 2019 09:15:26 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, hannes@cmpxchg.org,
        jiangshanlai@gmail.com, lizefan@huawei.com, bsd@redhat.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC v2 0/5] cgroup-aware unbound workqueues
References: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
 <20190605135319.GK374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605135319.GK374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19060606-0020-0000-0000-00000346FEB7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060606-0021-0000-0000-0000219A1108
Message-Id: <20190606061525.GD23056@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060046
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Wed, Jun 05, 2019 at 06:53:19AM -0700, Tejun Heo wrote:
> Hello, Daniel.
> 
> On Wed, Jun 05, 2019 at 09:36:45AM -0400, Daniel Jordan wrote:
> > My use case for this work is kernel multithreading, the series formerly known
> > as ktask[2] that I'm now trying to combine with padata according to feedback
> > from the last post.  Helper threads in a multithreaded job may consume lots of
> > resources that aren't properly accounted to the cgroup of the task that started
> > the job.
> 
> Can you please go into more details on the use cases?

If I remember correctly, the original Bandan's work was about using
workqueues instead of kthreads in vhost. 
 
> For memory and io, we're generally going for remote charging, where a
> kthread explicitly says who the specific io or allocation is for,
> combined with selective back-charging, where the resource is charged
> and consumed unconditionally even if that would put the usage above
> the current limits temporarily.  From what I've been seeing recently,
> combination of the two give us really good control quality without
> being too invasive across the stack.
> 
> CPU doesn't have a backcharging mechanism yet and depending on the use
> case, we *might* need to put kthreads in different cgroups.  However,
> such use cases might not be that abundant and there may be gotaches
> which require them to be force-executed and back-charged (e.g. fs
> compression from global reclaim).
> 
> Thanks.
> 
> -- 
> tejun
> 

-- 
Sincerely yours,
Mike.

