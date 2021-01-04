Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F072E2E9881
	for <lists+cgroups@lfdr.de>; Mon,  4 Jan 2021 16:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbhADP3b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Jan 2021 10:29:31 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:44450 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbhADP3b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Jan 2021 10:29:31 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 104FSAqY022528;
        Mon, 4 Jan 2021 15:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=AVQahVYreNEK2Vi11CqdSHwDA2Hdtxm2MaBe4FwYlI8=;
 b=O5qEQ6UAoJ1kVi7bxCgrf2pfAD3imhJuo3RzADBDyQacBccCxMd/r7dDZTiUhf5Kh1ug
 9fstrHPyvmKSETMi8wcLIqQ3/14I4D6nTgM7TlF2ufJuq+pVdwoTNGH3iuCSOveNgcA3
 /9kwdkVhP0l98NCVBkHLf9KWf4Ln77vMuG4/Btr/YnpwhFAOyOp3k/0N1WwVCuqe2DQV
 8Eb9zgUzn6ZebrC2jwXXnVPAZQuB+RAsk1QIvMgnp7/EoXmKE2ruilUZYapxX4x5z2WQ
 j48uk4iiqqB3he7H7r8Wnd4uBH7SUUiqDusODy1Pj9ksS6lRhYSV+EFqwvScwNFGDU1z nw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 35u2xfyyfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jan 2021 15:28:40 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D92D261;
        Mon,  4 Jan 2021 15:28:39 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.160.247])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 4ACF448;
        Mon,  4 Jan 2021 15:28:38 +0000 (UTC)
Date:   Mon, 4 Jan 2021 09:28:38 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Zefan Li <lizefan@huawei.com>
Cc:     Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH] cpuset: Remove stale URLs in the MAINTAINERS entry
Message-ID: <20210104152838.GA144275@swahl-home.5wahls.com>
References: <42668f2c-5ea1-da38-918e-ac4c86e3f03d@huawei.com>
 <2822d565280536f36ea6ddd521a7716813ef85a2.camel@perches.com>
 <39449cc4-15bf-4570-2bbd-dd47ea73b86c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39449cc4-15bf-4570-2bbd-dd47ea73b86c@huawei.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-04_10:2021-01-04,2021-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=828 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1011 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040101
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 28, 2020 at 02:31:52PM +0800, Zefan Li wrote:
> On 2020/12/28 14:01, Joe Perches wrote:
> > On Mon, 2020-12-28 at 11:17 +0800, Zefan Li wrote:
> >> Those URLs are no longer accessable.
> > 
> > The general argument to avoid removal of these no longer valid links
> > is that they may still be available from archive.org.
> > 
> > ...
> > 
> > It may be appropriate to copy the content into a local Documentation
> > file somewhere to avoid the need to lookup old reference links.
> > 
> 
> I don't think the contents in those links provide valuable information about cpusets.
> We have documents in Documentation/admin-guide/cgroup/ and man cpuset(7). So I think
> we can just remove them.

I agree, I did the archive.org lookup and it appeared that the current
version of most of this information is already under the Documentation
tree.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
