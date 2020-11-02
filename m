Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3E32A2F62
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgKBQJu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 11:09:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52234 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgKBQJu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 11:09:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2G9fPP082406;
        Mon, 2 Nov 2020 16:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=s5s8+s0XNuoA1n0Xmu2wW9hwDujD3Ki9LMC4+zTMlxw=;
 b=vo45Yog4xFjVF97suIFIOjVQk5cZk0X8MaoKBEWEHzNfiMxnPXMQUJifG10U9l9zhzR6
 LB25nqeRBJiRdKCfaok+WUauYGyyHBrqQqa6gL/xdGCirAobM3+lmoW0b2e/A3j5YRFl
 xCzOWW3WKTqvUSflsW7FOxkAt/Vp8gSG4/7TVMnAUfWe3Zpl93gp5/S+jgai8XR9cLva
 zDuJ01YX7Zi4aAUnPA6uwMuRMxKeB1LfMPrhsCNJE/HBDx+50OsSYChSvOjMOhnxctWZ
 2n9iwVU5p8lPIlEBt4bfc32jLJIs+jgReYHj3g7stsXOkNOMYwIz0Aqe1Yr7R+fpGy/N RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34hhb1vs2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 16:09:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2FojQM166132;
        Mon, 2 Nov 2020 16:09:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34jf46qr9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 16:09:44 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A2G9iQI030839;
        Mon, 2 Nov 2020 16:09:44 GMT
Received: from OracleT490.vogsphere (/73.203.30.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 08:09:43 -0800
Subject: Re: [QUESTION] Cgroup namespace and cgroup v2
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org
References: <d223c6ba-9fcf-8728-214b-1bce30f26441@oracle.com>
 <20201027182659.GA62134@blackbook>
 <001e7b1d-1b7c-e3d8-493f-2b78b3b093b1@oracle.com>
 <20201102140921.GA4691@blackbook>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <5be94abd-1663-55e1-01a7-f36405fb0669@oracle.com>
Date:   Mon, 2 Nov 2020 09:09:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102140921.GA4691@blackbook>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020125
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/2/20 7:09 AM, Michal Koutný wrote:
> On Fri, Oct 30, 2020 at 07:11:20AM -0600, Tom Hromatka <tom.hromatka@oracle.com> wrote:
>> Would you mind sharing some of the other discrepancies?  I
>> would like to be prepared when we run into them as well.
> Search for CFTYPE_NOT_ON_ROOT flag (that was on my mind above). It
> causes a visible difference between host and container (OTOH, you won't
> be able to write into such files typically, so that's effectively equal
> to the host).

Awesome!  Thanks.

Tom

>
> Michal
>

